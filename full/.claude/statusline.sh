#!/usr/bin/env bash
# Claude Code status line: model │ kube context │ context/plan usage │ git branch │ AWS profile
# Input: session JSON on stdin. Output: one line (ANSI colors allowed).

export LC_ALL=C.UTF-8  # "." decimals for printf regardless of user locale
in=$(cat)
model="?"

# Keep the last payload for debugging field names.
cache=~/.cache/claude-statusline
mkdir -p "$cache" 2>/dev/null && printf '%s' "$in" > "$cache/last.json"

eval "$(jq -r '@sh "model=\(.model.display_name // .model.id // "?")
dir=\(.workspace.current_dir // .cwd // "")
ctx=\(.context_window.used_percentage // "")
h5=\(.rate_limits.five_hour.used_percentage // "")
d7=\(.rate_limits.seven_day.used_percentage // "")
h5reset=\(.rate_limits.five_hour.resets_at // "")
effort=\(.effort.level // "")
thinking=\(.thinking.enabled | if . == null then "" else tostring end)
prnum=\(.pr.number // "")
prstate=\(.pr.review_state // "")"' <<<"$in" 2>/dev/null)"

R=$'\e[0m'; DIM=$'\e[2m'; BOLD=$'\e[1m'
RED=$'\e[31m'; GREEN=$'\e[32m'; YELLOW=$'\e[33m'; CYAN=$'\e[36m'; MAGENTA=$'\e[35m'
SEP="${DIM} │ ${R}"

# Contexts matching this regex are shown in bold red.
PROD_RE='prod|production'

pct() { # value label -> colored "label N%"
  [ -z "$1" ] && return
  local n; n=$(printf '%.0f' "$1" 2>/dev/null) || return
  local c=$GREEN; [ "$n" -ge 50 ] && c=$YELLOW; [ "$n" -ge 80 ] && c=$RED
  printf '%s%s %s%d%%%s' "$DIM" "$2" "$c" "$n" "$R"
}

# Model (effort, thinking on/off)
meta=$effort
case $thinking in
  true)  meta+="${meta:+, }thinking" ;;
  false) meta+="${meta:+, }no thinking" ;;
esac
out="${MAGENTA}${model}${R}${meta:+ ${DIM}(${meta})${R}}"

# Kube context + namespace (single kubectl call).
IFS=$'\t' read -r kctx kns < <(kubectl config view --minify \
  -o jsonpath='{.current-context}{"\t"}{.contexts[0].context.namespace}' 2>/dev/null)
if [ -n "$kctx" ]; then
  kns=${kns:-default}
  if [[ $kctx =~ $PROD_RE ]]; then
    out+="${SEP}${BOLD}${RED}⎈ ${kctx}:${kns} PROD${R}"
  else
    out+="${SEP}${CYAN}⎈ ${kctx}${DIM}:${kns}${R}"
  fi
fi

# Usage: context window, then plan limits (5h / 7d) when provided.
u=$(pct "$ctx" ctx)
p5=$(pct "$h5" 5h); p7=$(pct "$d7" 7d)
# Time until the 5h window resets, e.g. 5h 28% ↻1h02m
if [ -n "$p5" ] && [ -n "$h5reset" ]; then
  left=$(( ${h5reset%.*} - $(date +%s) ))
  [ "$left" -gt 0 ] && p5+="${DIM} ↻$(printf '%dh%02dm' $((left/3600)) $((left%3600/60)))${R}"
fi
[ -n "$p5$p7" ] && u+="${u:+  }${p5}${p5:+${p7:+ }}${p7}"
[ -n "$u" ] && out+="${SEP}${u}"

# Git branch, * when tracked files are modified.
if [ -n "$dir" ] && br=$(git -C "$dir" symbolic-ref --short -q HEAD 2>/dev/null || git -C "$dir" rev-parse --short HEAD 2>/dev/null); then
  git -C "$dir" diff --quiet --ignore-submodules HEAD 2>/dev/null || br+="*"
  out+="${SEP}${GREEN}⎇ ${br}${R}"
fi

# PR for the current branch, colored by review state.
if [ -n "$prnum" ]; then
  case $prstate in
    approved)          pr="${GREEN}#${prnum} ✓${R}" ;;
    changes_requested) pr="${RED}#${prnum} ✗ changes${R}" ;;
    "")                pr="${CYAN}#${prnum}${R}" ;;
    *)                 pr="${YELLOW}#${prnum} ${prstate//_/ }${R}" ;;
  esac
  out+=" ${pr}"
fi

[ -n "$AWS_PROFILE" ] && [ "$AWS_PROFILE" != default ] && out+="${SEP}${YELLOW}aws:${AWS_PROFILE}${R}"

printf '%s\n' "$out"

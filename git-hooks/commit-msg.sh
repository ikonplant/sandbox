#!/usr/bin/env bash
COMMIT_MSG=$1
FIRST_LINE=`head -n1 $COMMIT_MSG`
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
PATTERN="^\[((FEATURE|BUGFIX|HOTFIX|TASK|FOLLOWUP) #[0-9]+|(TASK))\] [A-Z].{6,}$"
if ! [[ "$FIRST_LINE" =~ $PATTERN ]]; then
  printf "${RED}!§\$&#*\?\$§! Bad boy!!! Bad commit message \'${FIRST_LINE}\'! Your commit will be rejected!\n"
  printf "${NC}Use our pattern: ${YELLOW}${PATTERN}\n"
  printf "${NC}Good example: ${YELLOW}'[FEATURE #123456] Implement this fancy stuff'.\n"
  printf "${NC}Allowed keywords are: ${YELLOW}FEATURE, BUGFIX, HOTFIX, FOLLOWUP, TASK\n"
  printf "${NC}Minimal length: 7 chars, first char = capital letter\n"
  exit 1
fi

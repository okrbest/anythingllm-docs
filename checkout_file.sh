#!/bin/bash

# 대상 브랜치 설정
TARGET_BRANCH="main"

# 현재 브랜치의 파일 목록 가져오기
CURRENT_FILES=$(git ls-tree -r --name-only HEAD)

# 대상 브랜치의 파일 목록 가져오기
TARGET_FILES=$(git ls-tree -r --name-only $TARGET_BRANCH)

# 중복되지 않은 파일 목록 생성
UNIQUE_FILES=$(comm -23 <(echo "$TARGET_FILES" | sort) <(echo "$CURRENT_FILES" | sort))

# 중복되지 않은 파일이 있으면 체크아웃
if [ -n "$UNIQUE_FILES" ]; then
  echo "Checking out the following unique files from $TARGET_BRANCH:"
  echo "$UNIQUE_FILES"
  git checkout $TARGET_BRANCH -- $UNIQUE_FILES
else
  echo "No unique files to checkout from $TARGET_BRANCH."
fi
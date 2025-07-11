#!/bin/bash

# git clone https://github.com/minhalvp/android-mcp-server.git
# cd android-mcp-server
# uv python install 3.11
# uv sync
# claude mcp add android -- uv --directory /Users/vladislav_k/Code/mcp/android-mcp-server run server.py


echo 'Adding MCPs to Claude...'

echo 'Building context7-mcp Docker image...'
docker buildx build -t context7-mcp-image git@github.com:dezer32/context7.git
echo 'Done building context7-mcp Docker image.'

echo 'Building mcp-memory-service Docker image...'
docker buildx build -t mcp-memory-service git@github.com:dezer32/mcp-memory-service.git
echo 'Done building mcp-memory-service Docker image.'

claude mcp add claude               -- claude mcp serve
claude mcp add context7             -- docker run -i --rm context7-mcp-image
claude mcp add memory               -- docker run -i --rm \
  -v ${HOME}/.mcp-memory/share/chroma_db:/app/chroma_db \
  -v ${HOME}/.mcp-memory/share/backups:/app/backups \
  -e MCP_MEMORY_CHROMA_PATH='/app/chroma_db' \
  -e MCP_MEMORY_BACKUPS_PATH='/app/backups' \
  mcp-memory-service:latest
claude mcp add fetch                -- docker run -i --rm mcp/fetch
claude mcp add sequential-thinking  -- docker run -i --rm mcp/sequentialthinking
claude mcp add time                 -- docker run -i --rm mcp/time
claude mcp add filesystem           -- docker run -i --rm \
  --mount type=bind,src=${HOME}/Code/,dst=${HOME}/Code \
  --mount type=bind,src=${HOME}/.claude,dst=${HOME}/.claude \
  mcp/filesystem ${HOME}/Code ${HOME}/.claude
claude mcp add git                  -- docker run -i --rm \
  --mount type=bind,src=${HOME}/Code/,dst=${HOME}/Code/ \
  mcp/git



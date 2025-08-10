#git@github.com:dezer32/mcp-memory-service.git!/bin/bash

# git clone https://github.com/minhalvp/android-mcp-server.git
# cd android-mcp-server
# uv python install 3.11
# uv sync
# claude mcp add android -- uv --directory /Users/vladislav_k/Code/mcp/android-mcp-server run server.py


# echo 'Adding MCPs to Claude...'

echo 'Building context7-mcp Docker image...'
docker buildx build -t context7-mcp-image git@github.com:dezer32/context7.git
echo 'Done building context7-mcp Docker image.'
#
# echo 'Building mcp-memory-service Docker image...'
# docker buildx build -t mcp-memory-service git@github.com:dezer32/mcp-memory-service.git
# echo 'Done building mcp-memory-service Docker image.'

# claude mcp add context7             -- docker run -i --rm context7-mcp-image
# claude mcp add memory               -- docker run -i --rm \
#   -v ${HOME}/.mcp-memory/share/chroma_db:/app/chroma_db \
#   -v ${HOME}/.mcp-memory/share/backups:/app/backups \
#   -e MCP_MEMORY_CHROMA_PATH='/app/chroma_db' \
#   -e MCP_MEMORY_BACKUPS_PATH='/app/backups' \
#   mcp-memory-service:latest
# claude mcp add fetch                -- docker run -i --rm mcp/fetch
# claude mcp add sequential-thinking  -- docker run -i --rm mcp/sequentialthinking
# claude mcp add time                 -- docker run -i --rm mcp/time
# claude mcp add filesystem           -- docker run -i --rm \
#   --mount type=bind,src=${HOME}/Code/,dst=${HOME}/Code \
#   --mount type=bind,src=${HOME}/.claude,dst=${HOME}/.claude \
#   mcp/filesystem ${HOME}/Code ${HOME}/.claude
# claude mcp add git                  -- docker run -i --rm \
#   --mount type=bind,src=${HOME}/Code/,dst=${HOME}/Code/ \
#   mcp/git
#

# claude mcp add --scope user --transport http filesystem           http://localhost:9090/filesystem/mcp
# claude mcp add --scope user --transport http git                  http://localhost:9090/git/mcp
# claude mcp add --scope user --transport http time                 http://localhost:9090/time/mcp
# claude mcp add --scope user --transport http context7             http://localhost:9090/context7/mcp
# claude mcp add --scope user --transport http sequential-thinking  http://localhost:9090/sequential-thinking/mcp
# claude mcp add --scope user --transport http fetch                http://localhost:9090/fetch/mcp
# claude mcp add --scope user --transport http memory               http://localhost:9090/memory/mcp

# claude mcp add --scope user --transport http filesystem           http://localhost:12008/metamcp/filesystem/mcp
# claude mcp add --scope user --transport http git                  http://localhost:12008/metamcp/git/mcp
# claude mcp add --scope user --transport http time                 http://localhost:12008/metamcp/time/mcp
# claude mcp add --scope user --transport http context7             http://localhost:12008/metamcp/context7/mcp
# claude mcp add --scope user --transport http sequential-thinking  http://localhost:12008/metamcp/sequential-thinking/mcp
# claude mcp add --scope user --transport http fetch                http://localhost:12008/metamcp/fetch/mcp
# claude mcp add --scope user --transport http memory               http://localhost:12008/metamcp/memory/mcp
# claude mcp add --scope user --transport http repomix              http://localhost:12008/metamcp/repomix/mcp

# claude mcp add --scope user                  memory               -- docker run -i --rm \
#                                                                     -v ${HOME}/.mcp-memory/share/chroma_db:/app/chroma_db \
#                                                                     -v ${HOME}/.mcp-memory/share/backups:/app/backups \
#                                                                     -e MCP_MEMORY_CHROMA_PATH='/app/chroma_db' \
#                                                                     -e MCP_MEMORY_BACKUPS_PATH='/app/backups' \
#                                                                     mcp-memory-service:latest

# claude mcp add --scope user                  claude               -- ${HOME}/.claude/local/claude mcp serve
# claude mcp add --scope user                  jetbrains            -- npx -y @jetbrains/mcp-proxy

claude mcp remove --scope user filesystem
claude mcp remove --scope local filesystem

claude mcp remove --scope user context7
claude mcp remove --scope local context7

claude mcp remove --scope user firefly-iii
claude mcp remove --scope local firefly-iii

claude mcp remove --scope user git
claude mcp remove --scope local git

claude mcp remove --scope user memory
claude mcp remove --scope local memory

claude mcp remove --scope user time
claude mcp remove --scope local time

claude mcp remove --scope user sequential-thinking
claude mcp remove --scope local sequential-thinking

claude mcp remove --scope user fetch
claude mcp remove --scope local fetch

claude mcp remove --scope user repomix
claude mcp remove --scope local repomix

claude mcp remove --scope user claude
claude mcp remove --scope local claude

claude mcp remove --scope user codex
claude mcp remove --scope local codex

claude mcp add --scope user filesystem -- npx -y @modelcontextprotocol/server-filesystem /Users/vladislav_k/Code/ /Users/vladislav_k/Downloads/ /Users/vladislav_k/Documents/
# claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp
claude mcp add --scope user context7             -- docker run -i --rm context7-mcp-image

claude mcp add --scope user firefly-iii -- mcp-firefly-iii /Users/vladislav_k/.claude/firefly-iii.config.yaml

# claude mcp add --scope user firefly-iii -- npx -y @firefly-iii-mcp/local --pat eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNWMxZDAzYmZlNGFiZGE5ZjhkYWFhODQ0MTMyOGEyZjZkYmZkOWE0MTQ1YzBlOWMyYWMwNmNiMjhkMTMwZDBkOTFhYmEzNGFmZDFlYzQwODAiLCJpYXQiOjE3NTM1Mjk1OTQuNDIwNzU2LCJuYmYiOjE3NTM1Mjk1OTQuNDIwNzU5LCJleHAiOjE3ODUwNjU1OTQuMzQ5ODkyLCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.FAV2slCZnXNe6afvpwOe1GXyDFEfOskxInCYuQVOEOOVmcWJfzlyRezC5iVXuNuep0zlaRgSZz4LgUkLv12hyw4X0WYmGVdqy9nIthgBrzvYaPfNG3Vv8Ag7MsEe5U6EkspRMDAknzNEL970IaIC2-xMx5h4A7oJyDjCUYaI8BS8UFF1mE8kVWlLFmdFgORwkbQkEUMuFp9TViyh9ZxdVEV6VQtYsLxLVUER8rw3t6BIPfoHUrcn4IBq5FCNHDf0xAaC6AkfkdEYOqBd37OYm0fCkMnA-NEaUgA_xBUXxQ4WTMrfpKTjTPNU2yxg5IPD211rM9sk_P5UgoEdqw_Go_DN3rmep_-TwtZ1hUuexm7mQJD2tWtAcETR9X1UW47SNsGzriwCGsY0JOc9noJeecu3fn7CFosIrjpM9RBv_eg0kIhVVpbKF8QWMaKdlsRRP-TpvObkNf9GlHvSW5CEBax_ilEz8kbPSLePOTQdgOKOsOMsOGGWlDcqIr2s2q0ahcUCKOIAJMgaPHaX3g9wJCvWAh4dHQtDRUn--mvqrKTas0LHbeiyqS2uC9yT8R0nn9vfNUhshe-901BPGK6CCuvynVuoivgR60yXYMZzB0pEqO5mdR57dBI2eZjIjfZOLcgMz2LOcAsPL_Wr8duEUTGpGSMF2cYqC1-1e8rPI4c --baseUrl https://funds.appservice.space
claude mcp add --scope user git -- uvx mcp-server-git
claude mcp add --scope user memory -e MEMORY_FILE_PATH="/Users/vladislav_k/.claude/mcp-memory/memory.json" -- npx -y @modelcontextprotocol/server-memory
claude mcp add --scope user time -- uvx mcp-server-time
claude mcp add --scope user sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking
claude mcp add --scope user fetch -- uvx mcp-server-fetch
claude mcp add --scope user repomix -- repomix --mcp
claude mcp add --scope user claude -- /Users/vladislav_k/.claude/local/claude mcp serve
claude mcp add --scope user codex -- codex -m gpt-5 mcp

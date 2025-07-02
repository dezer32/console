#!/bin/bash

echo 'Adding MCPs to Claude...'

echo 'Building context7-mcp Docker image...'
docker build -t context7-mcp-image - <<EOF
FROM node:18-alpine

WORKDIR /app

RUN npm install -g @upstash/context7-mcp

CMD ["context7-mcp"]
EOF
echo 'Done building context7-mcp Docker image.'

claude mcp add context7             -- docker run -i --rm context7-mcp-image
claude mcp add everything           -- docker run -i --rm mcp/everything
claude mcp add memory               -- docker run -i --rm -v /Users/dezer/.mcp-memory/share/chroma_db:/app/chroma_db -v /Users/dezer/.mcp-memory/share/backups:/app/backups -e MCP_MEMORY_CHROMA_PATH='/app/chroma_db' -e MCP_MEMORY_BACKUPS_PATH='/app/backups' mcp-memory-service:latest
claude mcp add fetch                -- docker run -i --rm mcp/fetch
claude mcp add sequential-thinking  -- docker run -i --rm mcp/sequentialthinking
claude mcp add time                 -- docker run -i --rm mcp/time
claude mcp add filesystem           -- docker run -i --rm --mount type=bind,src=/Users/dezer/Code/ai-invest,dst=/projects/ai-invest mcp/filesystem /projects
claude mcp add git                  -- docker run -i --rm --mount type=bind,src=/Users/dezer/Code/ai-invest,dst=/Users/dezer/Code/ai-invest mcp/git



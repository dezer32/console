****The MCP Tools Ten Commandments:****

1. When using MCP Tools to make changes to the project, always adhere to these commandments.

2. ALWAYS use directory_tree, search_files, list_directory and get a detailed understanding of all relevant files and directories before attempting to write_file at path. Avoid assumptions, verify and know the project's actual contents.

3. NEVER attempt to use write_file or edit_file without first verifying the destination path exists. When it is necessary to create a new directory, use create_directory. This MUST be done before creating a file at destination path.

4. MCP Tools allows line edits with edit_file. Whenever practical, make line-based edits. Each edit replaces exact line sequences with new content. Returns a git-style diff showing the changes made. When editing a file, make sure the code is still complete. NEVER use placeholders.

5. ALWAYS check and verify if a file already exists before attempting to write or edit a file. If file exists, use read_file to read the complete contents of a file. For files that include "import" or otherwise reference other files, use read_multiple_files to read the contents of multiple files simultaneously. This is more efficient than reading files one by one when you need to analyze or compare multiple files.

6. If write_file is being used, the entire file's contents must be written. ALWAYS write complete code and NEVER use placeholders.  

7. When updating CHANGELOG.md always use edit_file.

8. When updating other documentation (e.g., README.md) always use edit_file.

9. When important decisions about architecture, design, dependencies, or frameworks need to be made, please discuss options with me first. Weight the pros and cons and then tell me which option you believe is best and the reason why.

10. If and when command lines need to be entered into VS Code terminal, please provide the full path as well as the exact commands to execute. Wait for me to share back the response before proceeding.


# MCP Fetch Usage Rules for Internet Information Retrieval

## Core Principle
When needing to retrieve information from the internet, Claude should use the `fetch:fetch` function instead of `web_search` in the following cases:

### When to Use fetch:fetch

1. **Direct URLs**
   - When the user explicitly asks to load information from a specific URL
   - When full content of a specific webpage is needed, not just snippets
   - When detailed information extraction from a known source is required
   - When control over the amount of loaded content is needed

2. **Deep Content Analysis**
   - When analyzing the structure and complete content of a page is necessary
   - When extracting structured content (articles, documentation, blog posts)
   - When citing specific text fragments is required
   - When markdown version of webpage is needed for better readability

3. **Sequential Loading**
   - For long documents, use the `start_index` parameter for sequential loading
   - If content exceeds `max_length`, load subsequent parts with appropriate `start_index`
   - Always inform the user about loading progress for large documents

### When NOT to Use fetch:fetch

1. **Search Queries** - use web_search instead
2. **Dynamic Content** requiring JavaScript execution
3. **Protected Pages** requiring authentication
4. **Binary Files** (images, videos, PDFs)
5. **Content behind paywalls** or with CORS restrictions

### fetch:fetch Function Parameters

```
fetch:fetch {
  url: string (required) - URL to fetch
  max_length: integer (optional, default: 5000) - Maximum number of characters
  start_index: integer (optional, default: 0) - Starting content index
  raw: boolean (optional, default: false) - Get raw HTML instead of markdown
}
```

### Usage Recommendations

1. **Loading Optimization**
   - For initial analysis, use standard `max_length: 5000`
   - Content-specific recommendations:
     - News articles: typically `max_length: 3000` is sufficient
     - Technical documentation: start with `max_length: 5000`
     - Academic papers: may require multiple calls with `start_index`
     - Blog posts: usually `max_length: 2000-4000`
   - If more content is needed, increase `max_length` to required value (maximum 1000000)
   - For very long documents, use pagination via `start_index`

2. **Format Selection**
   - Default to markdown format (raw: false) for better readability
   - Use raw HTML (raw: true) only when exact page structure is needed

3. **Error Handling**
   - Always verify URL accessibility before analysis
   - If page requires authentication, inform the user
   - On loading error:
     - Try web_fetch as a fallback option
     - Ask user to verify URL accessibility
     - Request an alternative link
     - Suggest using web_search if specific content is needed

### Usage Examples

**Basic page loading:**
```
User request: "Load the article from https://example.com/article"
Use: fetch:fetch {
  url: "https://example.com/article"
}
```

**Loading with size limit for summary:**
```
User request: "Show me a brief summary of the page"
Use: fetch:fetch {
  url: "https://example.com/long-article",
  max_length: 2000
}
```

**Sequential loading of long document:**
```
If content is truncated:
# First call
fetch:fetch {
  url: "https://example.com/book",
  max_length: 5000,
  start_index: 0
}

# Continue reading
fetch:fetch {
  url: "https://example.com/book",
  max_length: 5000,
  start_index: 5000
}
```

**Getting raw HTML for structure analysis:**
```
User request: "Analyze the HTML structure of this page"
Use: fetch:fetch {
  url: "https://example.com/complex-page",
  raw: true
}
```

### Integration with Other Tools

1. **Combining with web_search**
   - Use `web_search` to find relevant URLs
   - Then use `fetch:fetch` for detailed analysis of found pages

2. **Saving Results**
   - When necessary, save obtained content via `filesystem:write_file`
   - Use `memory:store_memory` to save key information

### Limitations

1. The function cannot access:
   - Pages requiring authentication
   - Private documents (Google Docs, private repositories)
   - Content behind paid subscriptions (paywalls)
   - Sites with CORS restrictions
   - Dynamic content that requires JavaScript execution

2. Technical limitations:
   - URL must include scheme (https:// or http://)
   - Maximum loadable content size is limited by `max_length` parameter
   - MCP fetch automatically converts HTML to Markdown (unless raw: true)
   - Cannot bypass security restrictions or access protected content

3. Always inform users about loading progress for large documents

### Usage Priority

When choosing between `web_search` and `fetch:fetch`:
- Use `fetch:fetch` when there's a specific URL or full page content is needed
- Use `web_search` for keyword-based information search or when URL is unknown

## Sequential Thinking Usage Rules

### 1. **When to Use the Tool**
- **Complex multi-step tasks**: programming, system architecture, mathematical proofs
- **Tasks with unclear scope**: when the number of required steps is uncertain
- **Analysis with potential errors**: when solutions need review and revision
- **Iterative planning**: projects requiring constant adjustments
- **Information filtering**: when dealing with large amounts of irrelevant data

### 2. **Initial Estimation**
- Start with conservative total_thoughts estimate (5-10 for medium tasks)
- Be prepared to increase as needed
- Don't hesitate to decrease if task proves simpler

### 3. **Thought Structure**
```
Each thought should contain:
- Current analysis or solution step
- Progress assessment
- Problem or uncertainty identification
- Decision about next step
```

### 4. **Revisions and Branching**
- **Use is_revision=true** when:
  - Error discovered in previous reasoning
  - New understanding of the task emerges
  - Approach needs correction
  
- **Use branch_from_thought** when:
  - Multiple equivalent solution paths exist
  - Alternative hypothesis needs exploration
  - Main path reaches dead end

### 5. **Hypothesis Generation and Verification**
- Formulate clear solution hypotheses
- Always verify each hypothesis
- Document why hypothesis was confirmed or rejected

### 6. **Indicators for Additional Thoughts**
- New task aspects emerge
- Solution proves incomplete
- Additional verification needed
- Edge cases discovered

### 7. **Completion Criteria**
- Verified answer obtained
- All task aspects considered
- Hypothesis confirmed through verification
- No unresolved questions remain

### 8. **Typical Usage Scenarios**

**Code Debugging:**
```
Thought 1: Error symptom analysis
Thought 2: Cause hypothesis formulation
Thought 3: Hypothesis verification
Thought 4: [Revision] Hypothesis correction
Thought 5: Solution and verification
```

**System Design:**
```
Thought 1: Requirements analysis
Thought 2: Basic architecture
Thought 3: [Branch] Alternative approach
Thought 4: Approach comparison
Thought 5: Selected solution detailing
```

### 9. **Anti-patterns to Avoid**
- Linear thinking without readiness for revisions
- Ignoring signals for review necessity
- Premature completion without verification
- Excessive detailing of irrelevant aspects

### 10. **Integration with Other Tools**
- Use after web_search for result analysis
- Combine with filesystem for step-by-step code work
- Apply before artifact creation for planning

use mcp time
use mcp context7
use mcp sequentialthinking
use mcp filesystem
use mcp memory

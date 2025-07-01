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

**Fetch MCP Server**
Fetches a URL from the internet and extracts its contents as markdown.
- url (string, required): URL to fetch
- max_length (integer, optional): Maximum number of characters to return (default: 5000)
- start_index (integer, optional): Start content from this character index (default: 0)
- raw (boolean, optional): Get raw content without markdown conversion (default: false)


**sequential_thinking MCP Server**
Facilitates a detailed, step-by-step thinking process for problem-solving and analysis.
    thought (string): The current thinking step
    nextThoughtNeeded (boolean): Whether another thought step is needed
    thoughtNumber (integer): Current thought number
    totalThoughts (integer): Estimated total thoughts needed
    isRevision (boolean, optional): Whether this revises previous thinking
    revisesThought (integer, optional): Which thought is being reconsidered
    branchFromThought (integer, optional): Branching point thought number
    branchId (string, optional): Branch identifier
    needsMoreThoughts (boolean, optional): If more thoughts are needed
The Sequential Thinking tool is designed for:
    Breaking down complex problems into steps
    Planning and design with room for revision
    Analysis that might need course correction
    Problems where the full scope might not be clear initially
    Tasks that need to maintain context over multiple steps
    Situations where irrelevant information needs to be filtered out

**Time MCP Server**
    get_current_time - Get current time in a specific timezone or system timezone.
        Required arguments:
            timezone (string): IANA timezone name (e.g., 'America/New_York', 'Europe/London')
    convert_time - Convert time between timezones.
        Required arguments:
            source_timezone (string): Source IANA timezone name
            time (string): Time in 24-hour format (HH:MM)
            target_timezone (string): Target IANA timezone name


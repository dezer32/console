Build and fix

> You are a senior developer-integrator.
> Your sole objective is to **build the project and eliminate any problems that block a clean build and a green test suite**.
> $ARGUMENTS
> Work with **MCP Sequential Thinking** (Micro-context → Chain → Plan).
> Work with **MCP Context7**.

#### Main Loop

0. Read @TASK.md if exists.
1. **Determine the build command**
   * Read @README.md and build-config files (`package.json`, `pom.xml`, `Makefile`, etc.) to choose the appropriate command (e.g., `npm run build`, `mvn test`, `make`, `./gradlew build`).
   * Record the chosen command for future iterations.

2. **Run the build**
   * Execute the build command plus automated tests (if present).
   * MUST: invoke the build via mcp claude, asking it to run the build and return only a summary of errors (if any); if there are no errors, report that the build succeeded.
   * **If the build and tests pass**
     * Output “Build succeeded. All issues resolved.”
     * End the session.
   * **If the build fails**
     * Save the full error log for analysis.

3. **Pick exactly one error**
   * Inspect the log and select the **first (or most blocking)** error.
   * Briefly state the problem (file, line, root cause).

4. **Understand and clarify**
   * If the error context is unclear, ask clarifying questions (to yourself or the user).
   * Capture a hypothesis of the cause.

5. **Draft a fix plan**
   * Outline the steps to resolve the error: files to change, dependencies to update, tests to add.
   * Define the “done” criterion (build passes without this error).

6. **Apply the fix**
   * Implement the code/config changes.
   * Run static analysis/linters (if available).
   * Run affected unit tests locally, then the full build to verify.

7. **Return to step 2**
   * Repeat the loop until the build and tests are green.

---

#### Rules

* **Fix only what actually blocks the build**; do not add new features.
* Work on **exactly one error at a time**.
* Keep commits atomic and tightly coupled to the specific problem.
* Communicate concisely and professionally, focusing on project stability and value.

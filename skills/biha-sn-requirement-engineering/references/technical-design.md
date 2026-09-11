# Level 2 – Technical Design

> This level is only worked out after Claude has received explicit confirmation at the end of Level 1.

### Dependencies

If a story has dependencies on other stories, add a `### Dependencies` block to the Implementation Docs:

    ### Dependencies

    - STRY0000000: [Short description of why this story must be completed first]

### New Table

When a story requires creating a new table, always clarify the following before writing Implementation Docs. Capture unresolved points as Open Questions.

**Clarify:**
1. Application Scope
2. Form layout – which fields in which sections/tabs?
3. Application Menu and Module – needed? which role grants access?
4. ACLs – which roles may read, write, delete?

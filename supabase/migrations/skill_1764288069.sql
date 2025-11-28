INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'PyTorch Docstring Writing Guide - Write docstrings for PyTorch functions and methods following PyTorch conventions',
  'claude-code',
  'skill',
  '[
    {"solution": "Use raw strings (r\"\"\"...\"\"\") for all docstrings", "cli": {}, "manual": "All PyTorch docstrings must use raw strings to avoid issues with LaTeX/math backslashes. This prevents interpretation of backslashes as escape sequences.", "note": "Critical for docstrings containing mathematical notation"},
    {"solution": "Follow Sphinx/reStructuredText format for documentation", "cli": {}, "manual": "Use Sphinx/reStructuredText (reST) format for all docstrings. This includes proper use of directives like .. math::, .. note::, .. warning::, and roles like :class:, :func:, :meth:.", "note": "Follow conventions in torch/_tensor_docs.py and torch/nn/functional.py"},
    {"solution": "Structure docstring: signature, description, formulas, cross-references, args, returns, examples", "cli": {}, "manual": "Start with function signature showing all parameters. Add brief one-line description, then Args section with type annotations. Include Returns section. Add Examples section with >>> prompts. Use cross-references with :func:, :class:, :meth: roles.", "note": "Include all essential information - be concise but complete"},
    {"solution": "Document function signature with parameter defaults and return type", "cli": {}, "manual": "First line: r\\\"\\\"\\\"function_name(param1, param2, *, kwarg1=default1) -> ReturnType\\n. Show positional and keyword-only arguments (use * separator). Include default values. Show return type annotation. This line should NOT end with a period.", "note": "Use double colon (::) after Examples"},
    {"solution": "Use proper Args section formatting with types and descriptions", "cli": {}, "manual": "Format: Args:\\n    param_name (Type): description. For optional params: (Type, optional) and include Default: ``value`` at end. Use double backticks for inline code. Indent continuation lines by 2 spaces. Document all parameters with type annotations.", "note": "Include Default value for optional parameters"},
    {"solution": "Add mathematical formulas using Sphinx math directives", "cli": {}, "manual": "Use .. math:: directive for block equations and :math:\\`..\\` for inline math. Example: .. math:: \\\\text{Softmax}(x_{i}) = \\\\frac{\\\\exp(x_i)}{\\\\sum_j \\\\exp(x_j)}. Escape backslashes in raw strings.", "note": "Use LaTeX notation inside math directives"},
    {"solution": "Use Sphinx cross-references for related functions and classes", "cli": {}, "manual": "Use :class:\\`~torch.nn.ModuleName\\` for classes, :func:\\`torch.function_name\\` for functions, :meth:\\`~Tensor.method_name\\` for methods. The ~ prefix shows only last component (e.g., Conv2d instead of torch.nn.Conv2d).", "note": "Cross-references improve navigation and documentation quality"},
    {"solution": "Add warnings and notes for important caveats", "cli": {}, "manual": "Use .. note:: and .. warning:: admonitions for important information. Format:\\n\\n.. note::\\n    Important information here.\\n\\nUse for known limitations, performance tips, or usage recommendations.", "note": "Helps users avoid common mistakes"},
    {"solution": "Include Examples section with executable code", "cli": {}, "manual": "Use Examples:: with double colon. Use >>> prompt for Python code. Include comments with # when helpful. Show actual output when it helps understanding (indent without >>>). Always include at least one example when possible.", "note": "Examples are crucial for user understanding"},
    {"solution": "Reference documentation with external links", "cli": {}, "manual": "Use .. _Link Name:\\n    https://url.com format. Reference in text with \\`Link Name\\`_. Useful for linking to papers, arxiv, or external resources.", "note": "Helps users find related research or detailed explanations"}
  ]'::jsonb,
  'steps',
  'PyTorch codebase knowledge, understanding of Sphinx/reStructuredText format, familiarity with tensor operations',
  'Not using raw strings (r\"\"\") for docstrings, forgetting to include Examples section, inconsistent parameter documentation format, using single backticks instead of double, not including Default values for optional parameters, missing type annotations in Args section',
  'Docstring renders correctly in PyTorch documentation, all parameters are documented with types, examples execute without errors, cross-references are active, mathematical formulas display properly',
  'Guide for writing docstrings for PyTorch functions following Sphinx/reStructuredText conventions with proper formatting, cross-references, and examples.',
  'https://skillsmp.com/skills/pytorch-pytorch-claude-skills-docstring-skill-md',
  'admin:HAIKU_SKILL_1764288069'
);

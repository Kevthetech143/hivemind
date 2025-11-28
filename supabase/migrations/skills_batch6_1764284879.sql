INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pdf',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "PDF manipulation toolkit. Extract text/tables, create PDFs, merge/split, fill forms, for programmatic document processing and analysis."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'workflow_structure: 10, completeness: 10, error_handling: 5',
  'Score: 68, Tier: TIER_2_GOOD, Strengths: example_quality: 18, clarity_structure: 15, problem_definition: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-document-skills-pdf-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'etetoolkit',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Phylogenetic tree toolkit (ETE). Tree manipulation (Newick/NHX), evolutionary event detection, orthology/paralogy, NCBI taxonomy, visualization (PDF/SVG), for phylogenomics."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, error_handling: 10',
  'Score: 87, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-etetoolkit-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'metabolomics-workbench-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Access NIH Metabolomics Workbench via REST API (4,200+ studies). Query metabolites, RefMet nomenclature, MS/NMR data, m/z searches, study metadata, for metabolomics and biomarker discovery."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, completeness: 10, error_handling: 7',
  'Score: 79, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-metabolomics-workbench-database-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'deepchem',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Molecular machine learning toolkit. Property prediction (ADMET, toxicity), GNNs (GCN, MPNN), MoleculeNet benchmarks, pretrained models, featurization, for drug discovery ML."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 15, problem_definition: 10, completeness: 10',
  'Score: 87, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-deepchem-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'geniml',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "This skill should be used when working with genomic interval data (BED files) for machine learning tasks. Use for training region embeddings (Region2Vec, BEDspace), single-cell ATAC-seq analysis (scEm"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, completeness: 10, error_handling: 3',
  'Score: 80, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-geniml-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'zarr-python',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Chunked N-D arrays for cloud storage. Compressed arrays, parallel I/O, S3/GCS integration, NumPy/Dask/Xarray compatible, for large-scale scientific computing pipelines."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, error_handling: 6',
  'Score: 78, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 15, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-zarr-python-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pymoo',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Multi-objective optimization framework. NSGA-II, NSGA-III, MOEA/D, Pareto fronts, constraint handling, benchmarks (ZDT, DTLZ), for engineering design and optimization problems."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, completeness: 10, error_handling: 8',
  'Score: 80, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, clarity_structure: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pymoo-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'cosmic-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Access COSMIC cancer mutation database. Query somatic mutations, Cancer Gene Census, mutational signatures, gene fusions, for cancer research and precision oncology. Requires authentication."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'workflow_structure: 10, completeness: 10, error_handling: 6',
  'Score: 65, Tier: TIER_2_GOOD, Strengths: example_quality: 17, clarity_structure: 12, problem_definition: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-cosmic-database-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'shap',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Model interpretability and explainability using SHAP (SHapley Additive exPlanations). Use this skill when explaining machine learning model predictions, computing feature importance, generating SHAP p"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, error_handling: 13, clarity_structure: 10',
  'Score: 93, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-shap-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pylabrobot',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Laboratory automation toolkit for controlling liquid handlers, plate readers, pumps, heater shakers, incubators, centrifuges, and analytical equipment. Use this skill when automating laboratory workfl"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 10, example_quality: 9, problem_definition: 5',
  'Score: 59, Tier: TIER_2_GOOD, Strengths: workflow_structure: 15, error_handling: 10, clarity_structure: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pylabrobot-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'scientific-brainstorming',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Research ideation partner. Generate hypotheses, explore interdisciplinary connections, challenge assumptions, develop methodologies, identify research gaps, for creative scientific problem-solving."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'error_handling: 7, completeness: 5, example_quality: 0',
  'Score: 54, Tier: TIER_2_GOOD, Strengths: workflow_structure: 20, clarity_structure: 12, problem_definition: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-scientific-brainstorming-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'hypothesis-generation',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Generate testable hypotheses. Formulate from observations, design experiments, explore competing explanations, develop predictions, propose mechanisms, for scientific inquiry across domains."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, error_handling: 5, example_quality: 0',
  'Score: 57, Tier: TIER_2_GOOD, Strengths: workflow_structure: 15, completeness: 15, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-hypothesis-generation-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'neurokit2',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Comprehensive biosignal processing toolkit for analyzing physiological data including ECG, EEG, EDA, RSP, PPG, EMG, and EOG signals. Use this skill when processing cardiovascular signals, brain activi"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 5, workflow_structure: 5, error_handling: 1',
  'Score: 48, Tier: TIER_3_MEDIOCRE, Strengths: example_quality: 15, clarity_structure: 12, completeness: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-neurokit2-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'esm',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Comprehensive toolkit for protein language models including ESM3 (generative multimodal protein design across sequence, structure, and function) and ESM C (efficient protein embeddings and representat"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'workflow_structure: 10, clarity_structure: 10, error_handling: 2',
  'Score: 69, Tier: TIER_2_GOOD, Strengths: example_quality: 17, problem_definition: 15, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-esm-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'hypogenic',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Automated hypothesis generation and testing using large language models. Use this skill when generating scientific hypotheses from datasets, combining literature insights with empirical data, testing "}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 15, completeness: 15, error_handling: 8',
  'Score: 90, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-hypogenic-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'gtars',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "High-performance toolkit for genomic interval analysis in Rust with Python bindings. Use when working with genomic regions, BED files, coverage tracks, overlap detection, tokenization for ML models, o"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, workflow_structure: 10, error_handling: 2',
  'Score: 74, Tier: TIER_2_GOOD, Strengths: example_quality: 20, problem_definition: 15, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-gtars-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pydicom',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Python library for working with DICOM (Digital Imaging and Communications in Medicine) files. Use this skill when reading, writing, or modifying medical imaging data in DICOM format, extracting pixel "}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'error_handling: 15, completeness: 15, clarity_structure: 10',
  'Score: 90, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 20, problem_definition: 15, workflow_structure: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pydicom-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'scholar-evaluation',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Systematic framework for evaluating scholarly and research work based on the ScholarEval methodology. This skill should be used when assessing research papers, evaluating literature reviews, scoring r"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 10, example_quality: 5, error_handling: 5',
  'Score: 70, Tier: TIER_2_GOOD, Strengths: workflow_structure: 20, problem_definition: 15, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-scholar-evaluation-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'scientific-writing',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Write scientific manuscripts. IMRAD structure, citations (APA/AMA/Vancouver), figures/tables, reporting guidelines (CONSORT/STROBE/PRISMA), abstracts, for research papers and journal submissions."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, error_handling: 8, example_quality: 2',
  'Score: 67, Tier: TIER_2_GOOD, Strengths: workflow_structure: 20, completeness: 15, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-scientific-writing-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'peer-review',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Systematic peer review toolkit. Evaluate methodology, statistics, design, reproducibility, ethics, figure integrity, reporting standards, for manuscript and grant review across disciplines."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, error_handling: 10, example_quality: 2',
  'Score: 69, Tier: TIER_2_GOOD, Strengths: workflow_structure: 20, completeness: 15, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-peer-review-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pptx',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Presentation toolkit (.pptx). Create/edit slides, layouts, content, speaker notes, comments, for programmatic presentation creation and modification."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, problem_definition: 10',
  'Score: 92, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-document-skills-pptx-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'xlsx',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Spreadsheet toolkit (.xlsx/.csv). Create/edit with formulas/formatting, analyze data, visualization, recalculate formulas, for spreadsheet processing and analysis."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, problem_definition: 10',
  'Score: 92, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-document-skills-xlsx-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'fda-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Query openFDA API for drugs, devices, adverse events, recalls, regulatory submissions (510k, PMA), substance identification (UNII), for FDA regulatory data analysis and safety research."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, completeness: 10',
  'Score: 84, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-fda-database-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'literature-review',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Conduct comprehensive, systematic literature reviews using multiple academic databases (PubMed, arXiv, bioRxiv, Semantic Scholar, etc.). This skill should be used when conducting systematic literature"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, error_handling: 10',
  'Score: 89, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-literature-review-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'docx',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Document toolkit (.docx). Create/edit documents, tracked changes, comments, formatting preservation, text extraction, for professional document processing."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, error_handling: 7',
  'Score: 84, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-document-skills-docx-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'protocolsio-integration',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Integration with protocols.io API for managing scientific protocols. This skill should be used when working with protocols.io to search, create, update, or publish protocols; manage protocol steps and"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'error_handling: 15, clarity_structure: 12, completeness: 10',
  'Score: 89, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-protocolsio-integration-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'dask',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Parallel/distributed computing. Scale pandas/NumPy beyond memory, parallel DataFrames/Arrays, multi-file processing, task graphs, for larger-than-RAM datasets and parallel workflows."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, error_handling: 8',
  'Score: 78, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 17, workflow_structure: 16, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-dask-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'markitdown',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Convert various file formats (PDF, Office documents, images, audio, web content, structured data) to Markdown optimized for LLM processing. Use when converting documents to markdown, extracting text f"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 5, workflow_structure: 5, error_handling: 5',
  'Score: 52, Tier: TIER_2_GOOD, Strengths: example_quality: 15, clarity_structure: 12, completeness: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-markitdown-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'alphafold-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Access AlphaFold''''s 200M+ AI-predicted protein structures. Retrieve structures by UniProt ID, download PDB/mmCIF files, analyze confidence metrics (pLDDT, PAE), for drug discovery and structural biolog"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, workflow_structure: 10',
  'Score: 79, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 17, error_handling: 15, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-alphafold-database-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'arboreto',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Infer gene regulatory networks (GRNs) from gene expression data using scalable algorithms (GRNBoost2, GENIE3). Use when analyzing transcriptomics data (bulk RNA-seq, single-cell RNA-seq) to identify t"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 10, error_handling: 7, problem_definition: 5',
  'Score: 65, Tier: TIER_2_GOOD, Strengths: example_quality: 18, clarity_structure: 15, workflow_structure: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-arboreto-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'chembl-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Query ChEMBL''''s bioactive molecules and drug discovery data. Search compounds by structure/properties, retrieve bioactivity data (IC50, Ki), find inhibitors, perform SAR studies, for medicinal chemistr"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, error_handling: 2',
  'Score: 76, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-chembl-database-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'opentargets-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Query Open Targets Platform for target-disease associations, drug target discovery, tractability/safety data, genetics/omics evidence, known drugs, for therapeutic target identification."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, error_handling: 7',
  'Score: 79, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 15, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-opentargets-database-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'zinc-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Access ZINC (230M+ purchasable compounds). Search by ZINC ID/SMILES, similarity searches, 3D-ready structures for docking, analog discovery, for virtual screening and drug discovery."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, error_handling: 10',
  'Score: 79, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 17, workflow_structure: 15, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-zinc-database-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'statistical-analysis',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Statistical analysis toolkit. Hypothesis tests (t-test, ANOVA, chi-square), regression, correlation, Bayesian stats, power analysis, assumption checks, APA reporting, for academic research."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, problem_definition: 10, error_handling: 7',
  'Score: 79, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 17, workflow_structure: 15, clarity_structure: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-statistical-analysis-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'tooluniverse',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Use this skill when working with scientific research tools and workflows across bioinformatics, cheminformatics, genomics, structural biology, proteomics, and drug discovery. This skill provides acces"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 10, completeness: 10, error_handling: 9',
  'Score: 82, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 20, workflow_structure: 18, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-tooluniverse-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'scvi-tools',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "This skill should be used when working with single-cell omics data analysis using scvi-tools, including scRNA-seq, scATAC-seq, CITE-seq, spatial transcriptomics, and other single-cell modalities. Use "}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, completeness: 10, error_handling: 8',
  'Score: 75, Tier: TIER_1_EXCELLENT, Strengths: problem_definition: 15, workflow_structure: 15, example_quality: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-scvi-tools-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pubchem-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Query PubChem via PUG-REST API/PubChemPy (110M+ compounds). Search by name/CID/SMILES, retrieve properties, similarity/substructure searches, bioactivity, for cheminformatics."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, problem_definition: 10',
  'Score: 89, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pubchem-database-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'lamindb',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "This skill should be used when working with LaminDB, an open-source data framework for biology that makes data queryable, traceable, reproducible, and FAIR. Use when managing biological datasets (scRN"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 10, error_handling: 5',
  'Score: 82, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-lamindb-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'reportlab',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "PDF generation toolkit. Create invoices, reports, certificates, forms, charts, tables, barcodes, QR codes, Canvas/Platypus APIs, for professional document automation."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, completeness: 10, error_handling: 7',
  'Score: 71, Tier: TIER_2_GOOD, Strengths: example_quality: 17, workflow_structure: 15, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-reportlab-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'diffdock',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Diffusion-based molecular docking. Predict protein-ligand binding poses from PDB/SMILES, confidence scores, virtual screening, for structure-based drug design. Not for affinity prediction."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, error_handling: 12, problem_definition: 10',
  'Score: 92, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, clarity_structure: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-diffdock-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'anndata',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "This skill should be used when working with annotated data matrices in Python, particularly for single-cell genomics analysis, managing experimental measurements with metadata, or handling large-scale"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, workflow_structure: 10, error_handling: 2',
  'Score: 72, Tier: TIER_2_GOOD, Strengths: example_quality: 18, problem_definition: 15, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-anndata-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'transformers',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "This skill should be used when working with pre-trained transformer models for natural language processing, computer vision, audio, or multimodal tasks. Use for text generation, classification, questi"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 10, problem_definition: 5, error_handling: 0',
  'Score: 55, Tier: TIER_2_GOOD, Strengths: example_quality: 18, clarity_structure: 12, workflow_structure: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-transformers-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'umap-learn',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "UMAP dimensionality reduction. Fast nonlinear manifold learning for 2D/3D visualization, clustering preprocessing (HDBSCAN), supervised/parametric UMAP, for high-dimensional data."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, workflow_structure: 10, error_handling: 6',
  'Score: 73, Tier: TIER_2_GOOD, Strengths: example_quality: 20, completeness: 15, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-umap-learn-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pydeseq2',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Differential gene expression analysis (Python DESeq2). Identify DE genes from bulk RNA-seq counts, Wald tests, FDR correction, volcano/MA plots, for RNA-seq analysis."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, error_handling: 7',
  'Score: 84, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pydeseq2-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pufferlib',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "This skill should be used when working with reinforcement learning tasks including high-performance RL training, custom environment development, vectorized parallel simulation, multi-agent systems, or"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 10, problem_definition: 5, error_handling: 5',
  'Score: 69, Tier: TIER_2_GOOD, Strengths: workflow_structure: 20, example_quality: 17, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pufferlib-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'kegg-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Direct REST API access to KEGG (academic use only). Pathway analysis, gene-pathway mapping, metabolic pathways, drug interactions, ID conversion. For Python workflows with multiple databases, prefer b"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, problem_definition: 10',
  'Score: 89, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-kegg-database-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'exploratory-data-analysis',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Perform comprehensive exploratory data analysis on scientific data files across 200+ file formats. This skill should be used when analyzing any scientific data file to understand its structure, conten"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'error_handling: 15, clarity_structure: 13, completeness: 10',
  'Score: 90, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-exploratory-data-analysis-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'drugbank-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Access and analyze comprehensive drug information from the DrugBank database including drug properties, interactions, targets, pathways, chemical structures, and pharmacology data. This skill should b"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'example_quality: 6, problem_definition: 5, error_handling: 2',
  'Score: 55, Tier: TIER_2_GOOD, Strengths: workflow_structure: 20, clarity_structure: 12, completeness: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-drugbank-database-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'biomni',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Autonomous biomedical AI agent framework for executing complex research tasks across genomics, drug discovery, molecular biology, and clinical analysis. Use this skill when conducting multi-step biome"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, completeness: 10, error_handling: 7',
  'Score: 81, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-biomni-skill-md',
  'admin:MINER_BATCH_6'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'hmdb-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Access Human Metabolome Database (220K+ metabolites). Search by name/ID/structure, retrieve chemical properties, biomarker data, NMR/MS spectra, pathways, for metabolomics and identification."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 10, error_handling: 1, example_quality: 0',
  'Score: 48, Tier: TIER_3_MEDIOCRE, Strengths: workflow_structure: 15, clarity_structure: 12, problem_definition: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-hmdb-database-skill-md',
  'admin:MINER_BATCH_6'
);
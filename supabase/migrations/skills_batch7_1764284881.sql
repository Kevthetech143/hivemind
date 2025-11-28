INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'scientific-visualization',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Create publication figures with matplotlib/seaborn/plotly. Multi-panel layouts, error bars, significance markers, colorblind-safe, export PDF/EPS/TIFF, for journal-ready scientific plots."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 15, completeness: 15, problem_definition: 10',
  'Score: 92, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-scientific-visualization-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'simpy',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Process-based discrete-event simulation framework in Python. Use this skill when building simulations of systems with processes, queues, resources, and time-based events such as manufacturing systems,"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 15, completeness: 15, error_handling: 0',
  'Score: 82, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-simpy-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pytdc',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Therapeutics Data Commons. AI-ready drug discovery datasets (ADME, toxicity, DTI), benchmarks, scaffold splits, molecular oracles, for therapeutic ML and pharmacological prediction."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'workflow_structure: 5, problem_definition: 0, error_handling: 0',
  'Score: 44, Tier: TIER_3_MEDIOCRE, Strengths: example_quality: 17, clarity_structure: 12, completeness: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pytdc-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pysam',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Genomic file toolkit. Read/write SAM/BAM/CRAM alignments, VCF/BCF variants, FASTA/FASTQ sequences, extract regions, calculate coverage, for NGS data processing pipelines."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, error_handling: 11, problem_definition: 10',
  'Score: 88, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pysam-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pubmed-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Direct REST API access to PubMed. Advanced Boolean/MeSH queries, E-utilities API, batch processing, citation management. For Python workflows, prefer biopython (Bio.Entrez). Use this for direct HTTP/R"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, problem_definition: 10, error_handling: 3',
  'Score: 80, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, clarity_structure: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pubmed-database-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'get-available-resources',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "This skill should be used at the start of any computationally intensive scientific task to detect and report available system resources (CPU cores, GPUs, memory, disk space). It creates a JSON file wi"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 10, completeness: 10, error_handling: 6',
  'Score: 73, Tier: TIER_2_GOOD, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-get-available-resources-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'molfeat',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Molecular featurization for ML (100+ featurizers). ECFP, MACCS, descriptors, pretrained models (ChemBERTa), convert SMILES to features, for QSAR and molecular ML."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 15, problem_definition: 10, completeness: 10',
  'Score: 87, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-molfeat-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'rdkit',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Cheminformatics toolkit for fine-grained molecular control. SMILES/SDF parsing, descriptors (MW, LogP, TPSA), fingerprints, substructure search, 2D/3D generation, similarity, reactions. For standard w"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, problem_definition: 10',
  'Score: 87, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 15, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-rdkit-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'ensembl-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Query Ensembl genome database REST API for 250+ species. Gene lookups, sequence retrieval, variant analysis, comparative genomics, orthologs, VEP predictions, for genomic research."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, completeness: 10',
  'Score: 79, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 17, workflow_structure: 15, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-ensembl-database-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'aeon',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "This skill should be used for time series machine learning tasks including classification, regression, clustering, forecasting, anomaly detection, segmentation, and similarity search. Use when working"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, completeness: 10, problem_definition: 5',
  'Score: 77, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, error_handling: 13',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-aeon-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'clinpgx-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Access ClinPGx pharmacogenomics data (successor to PharmGKB). Query gene-drug interactions, CPIC guidelines, allele functions, for precision medicine and genotype-guided dosing decisions."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'error_handling: 13, clarity_structure: 12, problem_definition: 10',
  'Score: 87, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-clinpgx-database-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pdb-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Access RCSB PDB for 3D protein/nucleic acid structures. Search by text/sequence/structure, download coordinates (PDB/mmCIF), retrieve metadata, for structural biology and drug discovery."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 10, workflow_structure: 5, problem_definition: 0',
  'Score: 59, Tier: TIER_2_GOOD, Strengths: example_quality: 17, error_handling: 15, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pdb-database-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'ena-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Access European Nucleotide Archive via API/FTP. Retrieve DNA/RNA sequences, raw reads (FASTQ), genome assemblies by accession, for genomics and bioinformatics pipelines. Supports multiple formats."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, completeness: 10, error_handling: 2',
  'Score: 64, Tier: TIER_2_GOOD, Strengths: example_quality: 17, workflow_structure: 13, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-ena-database-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'seaborn',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Statistical visualization. Scatter, box, violin, heatmaps, pair plots, regression, correlation matrices, KDE, faceted plots, for exploratory analysis and publication figures."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, error_handling: 8',
  'Score: 77, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 17, workflow_structure: 15, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-seaborn-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pathml',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Computational pathology toolkit for analyzing whole-slide images (WSI) and multiparametric imaging data. Use this skill when working with histopathology slides, H&E stained images, multiplex immunoflu"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'error_handling: 7, example_quality: 6, problem_definition: 5',
  'Score: 55, Tier: TIER_2_GOOD, Strengths: workflow_structure: 15, clarity_structure: 12, completeness: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pathml-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'matplotlib',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Foundational plotting library. Create line plots, scatter, bar, histograms, heatmaps, 3D, subplots, export PNG/PDF/SVG, for scientific visualization and publication figures."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, error_handling: 1',
  'Score: 75, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-matplotlib-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'biopython',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Primary Python toolkit for molecular biology. Preferred for Python-based PubMed/NCBI queries (Bio.Entrez), sequence manipulation, file parsing (FASTA, GenBank, FASTQ, PDB), advanced BLAST workflows, s"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, completeness: 10',
  'Score: 82, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 20, workflow_structure: 15, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-biopython-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'reactome-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Query Reactome REST API for pathway analysis, enrichment, gene-pathway mapping, disease pathways, molecular interactions, expression analysis, for systems biology studies."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 10, workflow_structure: 5, error_handling: 0',
  'Score: 57, Tier: TIER_2_GOOD, Strengths: example_quality: 20, clarity_structure: 12, problem_definition: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-reactome-database-reactome-database-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pyopenms',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Python interface to OpenMS for mass spectrometry data analysis. Use for LC-MS/MS proteomics and metabolomics workflows including file handling (mzML, mzXML, mzTab, FASTA, pepXML, protXML, mzIdentML), "}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, completeness: 10, error_handling: 4',
  'Score: 78, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pyopenms-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'cellxgene-census',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Query CZ CELLxGENE Census (61M+ cells). Filter by cell type/tissue/disease, retrieve expression data, integrate with scanpy/PyTorch, for population-scale single-cell analysis."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, workflow_structure: 10, error_handling: 7',
  'Score: 71, Tier: TIER_2_GOOD, Strengths: example_quality: 17, completeness: 15, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-cellxgene-census-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'clinicaltrials-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Query ClinicalTrials.gov via API v2. Search trials by condition, drug, location, status, or phase. Retrieve trial details by NCT ID, export data, for clinical research and patient matching."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, problem_definition: 10',
  'Score: 85, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 17, workflow_structure: 16, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-clinicaltrials-database-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'geo-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Access NCBI GEO for gene expression/genomics data. Search/download microarray and RNA-seq datasets (GSE, GSM, GPL), retrieve SOFT/Matrix files, for transcriptomics and expression analysis."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, workflow_structure: 10, completeness: 10',
  'Score: 74, Tier: TIER_2_GOOD, Strengths: example_quality: 17, error_handling: 15, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-geo-database-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pymc-bayesian-modeling',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Bayesian modeling with PyMC. Build hierarchical models, MCMC (NUTS), variational inference, LOO/WAIC comparison, posterior checks, for probabilistic programming and inference."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, error_handling: 7, completeness: 5',
  'Score: 66, Tier: TIER_2_GOOD, Strengths: example_quality: 17, workflow_structure: 15, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pymc-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'latchbio-integration',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Latch platform for bioinformatics workflows. Build pipelines with Latch SDK, @workflow/@task decorators, deploy serverless workflows, LatchFile/LatchDir, Nextflow/Snakemake integration."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, problem_definition: 10',
  'Score: 92, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-latchbio-integration-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'sympy',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Use this skill when working with symbolic mathematics in Python. This skill should be used for symbolic computation tasks including solving equations algebraically, performing calculus operations (der"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'error_handling: 13, clarity_structure: 10, completeness: 5',
  'Score: 80, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-sympy-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'omero-integration',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Microscopy data management platform. Access images via Python, retrieve datasets, analyze pixels, manage ROIs/annotations, batch processing, for high-content screening and microscopy workflows."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'example_quality: 14, clarity_structure: 12, problem_definition: 10',
  'Score: 86, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, error_handling: 15, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-omero-integration-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'torchdrug',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Graph-based drug discovery toolkit. Molecular property prediction (ADMET), protein modeling, knowledge graph reasoning, molecular generation, retrosynthesis, GNNs (GIN, GAT, SchNet), 40+ datasets, for"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, completeness: 10, error_handling: 7',
  'Score: 76, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-torchdrug-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'stable-baselines3',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Use this skill for reinforcement learning tasks including training RL agents (PPO, SAC, DQN, TD3, DDPG, A2C, etc.), creating custom Gym environments, implementing callbacks for monitoring and control,"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, error_handling: 8',
  'Score: 87, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-stable-baselines3-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pytorch-lightning',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Deep learning framework (PyTorch Lightning). Organize PyTorch code into LightningModules, configure Trainers for multi-GPU/TPU, implement data pipelines, callbacks, logging (W&B, TensorBoard), distrib"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'example_quality: 9, problem_definition: 0, error_handling: 0',
  'Score: 51, Tier: TIER_2_GOOD, Strengths: workflow_structure: 20, clarity_structure: 12, completeness: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pytorch-lightning-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'astropy',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Comprehensive Python library for astronomy and astrophysics. This skill should be used when working with astronomical data including celestial coordinates, physical units, FITS files, cosmological cal"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 10, error_handling: 7, problem_definition: 5',
  'Score: 64, Tier: TIER_2_GOOD, Strengths: workflow_structure: 15, example_quality: 15, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-astropy-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'denario',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Multiagent AI system for scientific research assistance that automates research workflows from data analysis to publication. This skill should be used when generating research ideas from datasets, dev"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 5, workflow_structure: 5, error_handling: 2',
  'Score: 54, Tier: TIER_2_GOOD, Strengths: example_quality: 20, clarity_structure: 12, completeness: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-denario-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'scikit-survival',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Comprehensive toolkit for survival analysis and time-to-event modeling in Python using scikit-survival. Use this skill when working with censored survival data, performing time-to-event analysis, fitt"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, error_handling: 4',
  'Score: 81, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, problem_definition: 15, example_quality: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-scikit-survival-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'bioservices',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Primary Python tool for 40+ bioinformatics services. Preferred for multi-database workflows: UniProt, KEGG, ChEMBL, PubChem, Reactome, QuickGO. Unified API for queries, ID mapping, pathway analysis. F"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, completeness: 10',
  'Score: 84, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, error_handling: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-bioservices-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'pymatgen',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Materials science toolkit. Crystal structures (CIF, POSCAR), phase diagrams, band structure, DOS, Materials Project integration, format conversion, for computational materials science."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, completeness: 10',
  'Score: 87, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-pymatgen-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'modal',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Run Python code in the cloud with serverless containers, GPUs, and autoscaling. Use when deploying ML models, running batch processing jobs, scheduling compute-intensive tasks, or serving APIs that re"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, error_handling: 12, clarity_structure: 12',
  'Score: 91, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, problem_definition: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-modal-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'scanpy',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Single-cell RNA-seq analysis. Load .h5ad/10X data, QC, normalization, PCA/UMAP/t-SNE, Leiden clustering, marker genes, cell type annotation, trajectory, for scRNA-seq analysis."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, completeness: 10, error_handling: 4',
  'Score: 74, Tier: TIER_2_GOOD, Strengths: workflow_structure: 20, example_quality: 18, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-scanpy-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'clinvar-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Query NCBI ClinVar for variant clinical significance. Search by gene/position, interpret pathogenicity classifications, access via E-utilities API or FTP, annotate VCFs, for genomic medicine."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, problem_definition: 10, error_handling: 8',
  'Score: 85, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, clarity_structure: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-clinvar-database-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'vaex',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Use this skill for processing and analyzing large tabular datasets (billions of rows) that exceed available RAM. Vaex excels at out-of-core DataFrame operations, lazy evaluation, fast aggregations, ef"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 5, error_handling: 5, completeness: 5',
  'Score: 59, Tier: TIER_2_GOOD, Strengths: workflow_structure: 20, example_quality: 12, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-vaex-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'scikit-bio',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Biological data toolkit. Sequence analysis, alignments, phylogenetic trees, diversity metrics (alpha/beta, UniFrac), ordination (PCoA), PERMANOVA, FASTA/Newick I/O, for microbiome analysis."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, error_handling: 7',
  'Score: 77, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 20, completeness: 15, workflow_structure: 13',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-scikit-bio-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'histolab',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Digital pathology image processing toolkit for whole slide images (WSI). Use this skill when working with histopathology slides, processing H&E or IHC stained tissue images, extracting tiles from giga"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, error_handling: 8',
  'Score: 82, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 17, problem_definition: 15, workflow_structure: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-histolab-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'matchms',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Mass spectrometry analysis. Process mzML/MGF/MSP, spectral similarity (cosine, modified cosine), metadata harmonization, compound ID, for metabolomics and MS data processing."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'workflow_structure: 10, completeness: 10, error_handling: 5',
  'Score: 64, Tier: TIER_2_GOOD, Strengths: example_quality: 17, clarity_structure: 12, problem_definition: 10',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-matchms-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'cobrapy',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Constraint-based metabolic modeling (COBRA). FBA, FVA, gene knockouts, flux sampling, SBML models, for systems biology and metabolic engineering analysis."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, error_handling: 3',
  'Score: 77, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 17, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-cobrapy-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'gget',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "CLI/Python toolkit for rapid bioinformatics queries. Preferred for quick BLAST searches. Access to 20+ databases: gene info (Ensembl/UniProt), AlphaFold, ARCHS4, Enrichr, OpenTargets, COSMIC, genome d"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'workflow_structure: 14, problem_definition: 10, error_handling: 4',
  'Score: 78, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 20, clarity_structure: 15, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-gget-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'dnanexus-integration',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "DNAnexus cloud genomics platform. Build apps/applets, manage data (upload/download), dxpy Python SDK, run workflows, FASTQ/BAM/VCF, for genomics pipeline development and execution."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, error_handling: 10, completeness: 10',
  'Score: 82, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-dnanexus-integration-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'benchling-integration',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Benchling R&D platform integration. Access registry (DNA, proteins), inventory, ELN entries, workflows via API, build Benchling Apps, query Data Warehouse, for lab data management automation."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'clarity_structure: 12, problem_definition: 10, completeness: 10',
  'Score: 82, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 18, example_quality: 17, error_handling: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-benchling-integration-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'paper-2-web',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "This skill should be used when converting academic papers into promotional and presentation formats including interactive websites (Paper2Web), presentation videos (Paper2Video), and conference poster"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, clarity_structure: 12, error_handling: 10',
  'Score: 87, Tier: TIER_1_EXCELLENT, Strengths: example_quality: 20, problem_definition: 15, workflow_structure: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-paper-2-web-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'gene-database',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Query NCBI Gene via E-utilities/Datasets API. Search by symbol/ID, retrieve gene info (RefSeqs, GO, locations, phenotypes), batch lookups, for gene annotation and functional analysis."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, error_handling: 10, completeness: 10',
  'Score: 73, Tier: TIER_2_GOOD, Strengths: workflow_structure: 20, clarity_structure: 12, example_quality: 11',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-gene-database-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'datacommons-client',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Work with Data Commons, a platform providing programmatic access to public statistical data from global sources. Use this skill when working with demographic data, economic indicators, health statisti"}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 10, error_handling: 8, problem_definition: 5',
  'Score: 72, Tier: TIER_2_GOOD, Strengths: workflow_structure: 20, example_quality: 17, clarity_structure: 12',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-datacommons-client-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'scientific-critical-thinking',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "Evaluate research rigor. Assess methodology, experimental design, statistical validity, biases, confounding, evidence quality (GRADE, Cochrane ROB), for critical analysis of scientific claims."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'problem_definition: 10, error_handling: 9, example_quality: 2',
  'Score: 71, Tier: TIER_2_GOOD, Strengths: workflow_structure: 20, clarity_structure: 15, completeness: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-scientific-critical-thinking-skill-md',
  'admin:MINER_BATCH_7'
);

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, source_url, contributor_email)
VALUES (
  'deeptools',
  'claude-code',
  'skill',
  '[{"solution": "Skill Description", "cli": {"macos": "echo ''See SKILL.md''", "linux": "echo ''See SKILL.md''", "windows": "echo ''See SKILL.md''"}, "manual": "NGS analysis toolkit. BAM to bigWig conversion, QC (correlation, PCA, fingerprints), heatmaps/profiles (TSS, peaks), for ChIP-seq, RNA-seq, ATAC-seq visualization."}]'::jsonb,
  'manual',
  'Claude Code or compatible AI assistant',
  'completeness: 15, problem_definition: 10, error_handling: 8',
  'Score: 88, Tier: TIER_1_EXCELLENT, Strengths: workflow_structure: 20, example_quality: 20, clarity_structure: 15',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-deeptools-skill-md',
  'admin:MINER_BATCH_7'
);
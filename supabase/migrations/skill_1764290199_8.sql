INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'Scikit-Learn Integration - Machine learning workflows using scikit-learn',
  'claude-code',
  'skill',
  '[{"solution": "Import and use scikit-learn models for ML tasks", "cli": {"macos": "pip install scikit-learn && python -c \"from sklearn.ensemble import RandomForestClassifier\"", "linux": "pip install scikit-learn && python -c \"from sklearn.ensemble import RandomForestClassifier\"", "windows": "pip install scikit-learn && python -c \"from sklearn.ensemble import RandomForestClassifier\""}, "manual": "Use scikit-learn for supervised and unsupervised learning. Standard workflow: load data, train-test split, fit model, evaluate. Handle categorical features with encoders. Scale features with StandardScaler. Cross-validation for robust evaluation. Pipeline for reproducibility. GridSearchCV for hyperparameter tuning. Common models: RandomForest, LogisticRegression, SVM, KMeans. Check train/test performance gap for overfitting. Use feature importance analysis. Validate assumptions.", "note": "Always normalize/scale features before training. Use cross-validation instead of single train-test split. Check for overfitting by comparing train vs test scores."}]'::jsonb,
  'script',
  'Python 3.7+, scikit-learn installed, NumPy, Pandas',
  'Not scaling features. Ignoring train/test performance gap. Using wrong model for problem type. Forgetting to split data before fitting. No cross-validation. Hyperparameter tuning without validation. Memory issues with large datasets. Not checking for data leakage. Using accuracy for imbalanced datasets. No baseline comparison.',
  'Model trains without errors. Cross-validation scores reported. Train/test performance analyzed. Feature scaling applied. No data leakage. Appropriate metric chosen. Results reproducible.',
  'Scikit-learn machine learning models, pipelines, and workflow integration',
  'https://skillsmp.com/skills/k-dense-ai-claude-scientific-skills-scientific-skills-scikit-learn-skill-md',
  'admin:HAIKU_SKILL_1764290199_37706'
);

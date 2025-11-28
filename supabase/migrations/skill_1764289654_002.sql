INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'RAG Implementation - Build Retrieval-Augmented Generation systems for LLM applications with vector databases and semantic search',
  'claude-code',
  'skill',
  '[
    {"solution": "Vector Database Setup", "manual": "Choose database based on needs: Pinecone (managed, scalable), Weaviate (open-source, hybrid), Milvus (high performance), Chroma (lightweight), Qdrant (fast, filtered), FAISS (local deployment). Configure embeddings (text-embedding-ada-002, all-MiniLM-L6-v2, e5-large-v2)."},
    {"solution": "Document Chunking Strategies", "cli": {"macos": "python -c \"from langchain.text_splitters import RecursiveCharacterTextSplitter; s = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)\"", "linux": "python -c \"from langchain.text_splitters import RecursiveCharacterTextSplitter; s = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)\"", "windows": "python -c \"from langchain.text_splitters import RecursiveCharacterTextSplitter; s = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=200)\""}, "manual": "Use RecursiveCharacterTextSplitter for general text, TokenTextSplitter for token limits, SemanticChunker for semantic boundaries, MarkdownHeaderTextSplitter for markdown documents. Aim for 500-1000 token chunks with 10-20% overlap."},
    {"solution": "Retrieval Strategies", "manual": "Implement dense retrieval (semantic similarity), sparse retrieval (keyword matching), or hybrid search combining both. Use MultiQueryRetriever to generate query variations, HyDE for hypothetical documents. Add reranking with cross-encoders (BERT-based) or LLM-based scoring."},
    {"solution": "Advanced RAG Patterns", "manual": "Use EnsembleRetriever for hybrid search with custom weights, ContextualCompressionRetriever to compress documents, ParentDocumentRetriever for small retrieval chunks with large context. Add metadata filtering for category-based search."},
    {"solution": "Optimization and Reranking", "cli": {"macos": "python -c \"from sentence_transformers import CrossEncoder; model = CrossEncoder(''cross-encoder/ms-marco-MiniLM-L-6-v2'')\"", "linux": "python -c \"from sentence_transformers import CrossEncoder; model = CrossEncoder(''cross-encoder/ms-marco-MiniLM-L-6-v2'')\"", "windows": "python -c \"from sentence_transformers import CrossEncoder; model = CrossEncoder(''cross-encoder/ms-marco-MiniLM-L-6-v2'')\""}, "manual": "Use Maximal Marginal Relevance for relevance-diversity balance. Implement cross-encoder reranking to improve top results. Add metadata filtering and implement caching for production."},
    {"solution": "Prompt Engineering and Evaluation", "manual": "Design contextual prompts with instructions for grounding. Include citations with [1], [2] references. Add confidence scores. Measure accuracy, retrieval quality, and groundedness. Monitor production metrics continuously."}
  ]'::jsonb,
  'script',
  'Python, LLM fundamentals, understanding of embeddings and vector similarity',
  'Poor chunk size selection (too small loses context, too large reduces specificity), ignoring metadata filtering, not using hybrid search, missing reranking step, hallucinations from weak grounding prompts, insufficient evaluation metrics',
  'Documents successfully indexed and retrievable, relevant documents appear in top k results, answers grounded in retrieved context, citations accurate, evaluation metrics show >80% retrieval quality',
  'Complete RAG system implementation with vector databases, semantic search, reranking, and prompt optimization for accurate LLM-grounded responses',
  'https://skillsmp.com/skills/wshobson-agents-plugins-llm-application-dev-skills-rag-implementation-skill-md',
  'admin:HAIKU_SKILL_1764289654_89802'
);

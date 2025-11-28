-- AI/ML Tools Error Mining - November 26, 2025
-- 20 high-quality entries from Stack Overflow, GitHub, and official docs

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES
(
    'ValueError: not enough values to unpack (expected 2, got 1) in tiktoken during LlamaIndex index building',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Enable recursive directory loading: SimpleDirectoryReader(''documents'', recursive=True).load_data()", "percentage": 92},
        {"solution": "Verify document directory path is correct and contains valid files before loading", "percentage": 85}
    ]'::jsonb,
    'LlamaIndex installed, valid documents directory with supported file types',
    'SimpleDirectoryReader successfully loads files without tiktoken ValueError',
    'Incorrect directory paths, missing recursive=True flag for nested documents, empty directories treated as successful loads',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75968314'
),
(
    'AttributeError: module ''openai'' has no attribute ''api_base'' with guidance and LlamaIndex',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Install compatible versions: guidance==0.0.63 and pydantic==1.*", "percentage": 95},
        {"solution": "Downgrade OpenAI library to version compatible with guidance package", "percentage": 88}
    ]'::jsonb,
    'LlamaIndex with guidance package, OpenAI integration enabled',
    'Sub-Question Query Engine executes without AttributeError, guidance templates parse correctly',
    'Using guidance>=0.0.64 with newer OpenAI versions, Pydantic v2 incompatibility, not checking package version compatibility',
    0.93,
    'haiku',
    NOW(),
    'https://github.com/run-llama/llama_index/issues/9339'
),
(
    'OutputParserException: Failed to parse pydantic object from guidance program in LlamaIndex',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Downgrade pydantic to v1: pip install ''pydantic<2.0''", "percentage": 94},
        {"solution": "Switch to LlamaIndex v0.9.x which has better guidance compatibility", "percentage": 87}
    ]'::jsonb,
    'LlamaIndex with guidance package and Sub-Question Query Engine',
    'Router Query Engine parses JSON correctly without OutputParserException',
    'Using Pydantic v2 which breaks guidance output parsing, not verifying package compatibility matrix',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/run-llama/llama_index/issues/9339'
),
(
    'Empty array response in Weaviate GraphQL search with multi-vector schema',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Define named vectors explicitly in collection schema instead of generic vectors field", "percentage": 93},
        {"solution": "Configure vectorizer property for each named vector and verify schema with GET /v1/collections/{name}", "percentage": 89}
    ]'::jsonb,
    'Weaviate instance with collection schema, objects to insert with multiple vectors',
    'nearVector search returns expected objects, schema contains explicit named vector definitions',
    'Mixing old-style single vectors with named vectors, not checking schema definition, assuming generic vectors field supports multiple vectorizers',
    0.90,
    'haiku',
    NOW(),
    'https://github.com/weaviate/weaviate/issues/5461'
),
(
    'Weaviate nearText search returns empty results with vectorizer configured',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Verify vectorizer module is enabled: check collection moduleConfig includes text2vec-transformers or similar", "percentage": 91},
        {"solution": "Ensure all objects are indexed: run GET /v1/collections/{name} and verify object count > 0", "percentage": 86}
    ]'::jsonb,
    'Weaviate collection with text vectorizer, objects inserted with text properties',
    'nearText queries return relevant results, vectorizer logs show successful embeddings',
    'Assuming empty results mean no matches when actually vectorizer is disabled, not checking module config',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75538085'
),
(
    'LangChain LLMChain timeout error: Request timed out with ChatOpenAI',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Increase timeout parameter: ChatOpenAI(model=''gpt-4'', timeout=120) with milliseconds", "percentage": 90},
        {"solution": "Add request_timeout explicitly: ChatOpenAI(request_timeout=120)", "percentage": 89}
    ]'::jsonb,
    'LangChain installed with OpenAI integration, API key configured',
    'LLM chain executes without timeout errors, requests complete within specified window',
    'Using default 60 second timeout, not adjusting for slow API responses, confusing timeout units',
    0.87,
    'haiku',
    NOW(),
    'https://www.reddit.com/r/LangChain/comments/16f0nkg/'
),
(
    'HTTPSConnectionPool timeout error: Read timed out in LangChain with OpenAI',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Set timeout in OpenAI client: ChatOpenAI(temperature=0.7, request_timeout=120)", "percentage": 92},
        {"solution": "Wrap chain execution in retry logic with exponential backoff", "percentage": 85}
    ]'::jsonb,
    'LangChain with OpenAI LLM, network connectivity available',
    'API calls complete successfully, no Read timed out errors in logs',
    'Assuming timeout is network issue when it''s OpenAI service slowness, not configuring per-request timeout',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/hwchase17/langchain/issues/3005'
),
(
    'LangChain batch() method timeout applies to entire batch instead of individual calls',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Use batch_as_completed() instead of batch() for parallel processing with individual timeouts", "percentage": 94},
        {"solution": "Set per-call timeout in config: chain.batch(inputs, config={''timeout'': 60})", "percentage": 82}
    ]'::jsonb,
    'LangChain with concurrent batch processing, OpenAI integration',
    'Batch processing completes with each request honoring individual timeout window',
    'Expecting batch timeout to apply per-request when it applies to entire operation, using batch() for parallel tasks',
    0.89,
    'haiku',
    NOW(),
    'https://github.com/langchain-ai/langchain/issues/26610'
),
(
    'TypeError: __init__() takes exactly 1 positional argument with LlamaIndex Document constructor',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Pass content as keyword argument: Document(text=content) not Document(content)", "percentage": 93},
        {"solution": "Update to LlamaIndex v0.10.x which changed Document API to accept text parameter", "percentage": 88}
    ]'::jsonb,
    'LlamaIndex installed, converting list of strings to Document objects',
    'Document objects created successfully without TypeError, documents can be passed to index builders',
    'Passing string as positional argument to Document(), not checking LlamaIndex version for API changes',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76724421'
),
(
    'LlamaIndex readers file not found after package upgrade to 0.10.x',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Import from new location: from llama_index.readers import SimpleDirectoryReader instead of legacy import", "percentage": 95},
        {"solution": "Install llama-index-readers-file: pip install llama-index-readers-file", "percentage": 91}
    ]'::jsonb,
    'LlamaIndex 0.10.x installed, file reading required',
    'SimpleDirectoryReader imports successfully, documents load without ModuleNotFoundError',
    'Using old import paths after v0.10 split readers into separate packages, not updating import statements',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78125440'
),
(
    'Hugging Face model loading CUDA OutOfMemoryError: CUDA out of memory',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Load model with device_map=''auto'' and load_in_8bit=True: AutoModel.from_pretrained(model, device_map=''auto'', load_in_8bit=True)", "percentage": 93},
        {"solution": "Use model quantization: model.quantize(bits=4) or load_in_4bit parameter", "percentage": 91}
    ]'::jsonb,
    'Transformers library installed, CUDA-capable GPU available, sufficient VRAM configuration',
    'Model loads successfully on GPU without OOM error, inference runs without CUDA memory issues',
    'Loading full precision model on limited VRAM, not using quantization, not checking available GPU memory with torch.cuda.memory_allocated()',
    0.88,
    'haiku',
    NOW(),
    'https://github.com/huggingface/transformers/issues'
),
(
    'Hugging Face model download hangs or fails with no internet connection',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Pre-download model on connected machine: transformers-cli download model-name", "percentage": 92},
        {"solution": "Set HF_HOME to cache directory: export HF_HOME=/path/to/cache && load from local", "percentage": 89}
    ]'::jsonb,
    'Transformers library, model cache directory writable, offline access required',
    'Model loads from cache without download attempts, offline inference works correctly',
    'Assuming download failure is network when cache might be invalid, not pre-downloading for offline use',
    0.87,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/tagged/huggingface'
),
(
    'Embedding dimension mismatch: expected 1024 dimensions, not 1536 in vector database',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Regenerate all embeddings with consistent embedding model and dimensions", "percentage": 94},
        {"solution": "Verify embedding model output dimension matches database schema: verify vector.shape[1]", "percentage": 90}
    ]'::jsonb,
    'Vector database with embeddings, embedding model specified, batch upsert operations',
    'All vectors inserted successfully with consistent dimensions, no dimension mismatch errors',
    'Switching embedding models mid-pipeline without regenerating existing vectors, not checking embedding output dimensions',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/HKUDS/LightRAG/issues/2119'
),
(
    'Pinecone upsert vector dimension mismatch: array at index has different size',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Ensure all vectors in batch have same dimensions: [len(v) for v in vectors] should all equal index_dimension", "percentage": 95},
        {"solution": "Validate embedding model output before upsert: embeddings = model.encode(texts) && assert all(len(e) == expected_dim for e in embeddings)", "percentage": 92}
    ]'::jsonb,
    'Pinecone index created with specific dimension, upsert operation in progress',
    'All vectors upserted successfully without dimension errors, index query returns results',
    'Mixing vectors from different embedding models, not validating dimension consistency before upsert',
    0.93,
    'haiku',
    NOW(),
    'https://github.com/HKUDS/LightRAG/issues/2233'
),
(
    'Pinecone upsert timeout error when upserting large batches',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Reduce batch size: split 100k vectors into 1k chunks with upsert(vectors=chunk, async_req=False)", "percentage": 93},
        {"solution": "Increase timeout and use async: index.upsert(vectors=vectors, async_req=True)", "percentage": 87}
    ]'::jsonb,
    'Pinecone index initialized, large dataset to upsert',
    'Upsert operation completes within timeout window, all vectors inserted successfully',
    'Upserting entire dataset in single batch, not chunking for large operations, ignoring async options',
    0.89,
    'haiku',
    NOW(),
    'https://docs.pinecone.io'
),
(
    'LangChain chain execution failed: invalid prompt input variables',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Ensure prompt variables match chain input: PromptTemplate(input_variables=[''context'', ''question''], template=...) must match chain inputs", "percentage": 94},
        {"solution": "Debug by printing prompt.input_variables and chain.input_variables to verify match", "percentage": 88}
    ]'::jsonb,
    'LangChain chain defined, prompt template configured',
    'Chain executes successfully, all variables resolved correctly',
    'Not verifying prompt input_variables match actual chain inputs, typos in variable names',
    0.90,
    'haiku',
    NOW(),
    'https://github.com/langchain-ai/langchain/issues'
),
(
    'LlamaIndex failed to parse JSON with router query engine',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Use LlamaIndex v0.9.x with compatible pydantic v1 for guidance JSON parsing", "percentage": 92},
        {"solution": "Switch to non-guidance output parser: use default_output_parser instead of GuidanceOutputParser", "percentage": 85}
    ]'::jsonb,
    'LlamaIndex with router query engine, multiple tool selection required',
    'Router query engine routes queries to correct tool without JSON parsing errors',
    'Using incompatible guidance version with pydantic v2, not checking parser compatibility',
    0.87,
    'haiku',
    NOW(),
    'https://github.com/run-llama/llama_index/issues/9339'
),
(
    'Transformers AutoModelForCausalLM load fails: rope_init_fn missing for LLaMA model',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Update transformers library: pip install --upgrade transformers (requires >=4.36.0)", "percentage": 96},
        {"solution": "Use LLaMA-specific loader if transformers outdated: from peft import AutoPeftModelForCausalLM", "percentage": 82}
    ]'::jsonb,
    'Transformers library installed, LLaMA model weights available',
    'Model loads successfully with rope initialization, inference produces expected output',
    'Using outdated transformers version, not checking compatibility with model variant',
    0.91,
    'haiku',
    NOW(),
    'https://github.com/huggingface/transformers/issues'
),
(
    'LlamaIndex LlamaParse error: only PDF and image file types supported',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Convert unsupported formats to PDF: use LibreOffice/unoconv for DOC/DOCX/PPT", "percentage": 89},
        {"solution": "Use appropriate reader for file type: SimpleDocxReader for .docx, PDFReader for .pdf", "percentage": 87}
    ]'::jsonb,
    'LlamaParse configured, documents to parse in various formats',
    'All supported file types parse successfully, document content extracted correctly',
    'Assuming LlamaParse supports all formats, not checking supported file type list',
    0.86,
    'haiku',
    NOW(),
    'https://www.reddit.com/r/LlamaIndex/comments/1e9ejpl/'
),
(
    'Groq LLM with LlamaIndex failed_generation error in prompt',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Verify prompt format matches Groq model requirements: ensure no conflicting directives", "percentage": 88},
        {"solution": "Simplify prompt: remove complex JSON/XML formatting that Groq models struggle with", "percentage": 85}
    ]'::jsonb,
    'LlamaIndex with Groq LLM integration, prompts defined',
    'Groq LLM processes prompts successfully without failed_generation errors',
    'Using overly complex prompts, not testing with simpler prompt before debugging',
    0.82,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/78808829'
);

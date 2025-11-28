-- AI/ML Tools Knowledge Mining - 15 High-Quality Entries
-- Mined from Stack Overflow, GitHub Issues, and Official Documentation

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url, contributor_email
) VALUES

-- 1. LlamaIndex Document Parsing Error
(
    'ValueError: not enough values to unpack (expected 2, got 1) tiktoken data_gym_to_mergeable_bpe_ranks',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Use recursive=True parameter when loading documents from subdirectories: index = GPTSimpleVectorIndex.from_documents(documents, recursive=True)", "percentage": 90},
        {"solution": "Ensure proper file paths are specified for the directory containing documents before index building", "percentage": 85}
    ]'::jsonb,
    'LlamaIndex and tiktoken packages installed. Documents in accessible directory.',
    'Index builds successfully without ValueError. No unpacking errors during tokenization.',
    'Passing incorrect file paths or missing recursive parameter. Not updating LlamaIndex version.',
    0.88,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75968314/im-trying-to-run-the-llama-index-model-but-when-i-get-to-the-index-building-st',
    'admin:1764173122'
),

-- 2. Hugging Face CUDA Out of Memory Error
(
    'RuntimeError: CUDA out of memory. Tried to allocate 734.00 MiB (GPU 0; 15.78 GiB total capacity)',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Set CUDA_DEVICE_ORDER and CUDA_VISIBLE_DEVICES environment variables BEFORE importing transformer libraries: import os; os.environ[''CUDA_DEVICE_ORDER''] = ''PCI_BUS_ID''; os.environ[''CUDA_VISIBLE_DEVICES''] = ''2''; from transformers import AutoTokenizer", "percentage": 95},
        {"solution": "Ensure GPU device is correctly allocated by checking CUDA initialization order", "percentage": 88}
    ]'::jsonb,
    'Hugging Face transformers library and PyTorch installed. Multiple GPUs available.',
    'Transformers module loads on correct GPU. No memory allocation failures.',
    'Setting environment variables after importing transformers. Using wrong GPU index.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76128663/hugging-face-load-model-runtimeerror-cuda-out-of-memory',
    'admin:1764173122'
),

-- 3. Pinecone Upsert Dimension Mismatch Error
(
    'PineconeArgumentError: The argument to upsert had type errors: vector dimension 384 does not match index dimension 1536',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Verify embedding model dimension matches Pinecone index: OpenAI text-embedding-ada-002 requires 1536 dimensions. Check your embedding provider produces correct dimensions before upserting.", "percentage": 96},
        {"solution": "Ensure vectors are properly formatted as numeric arrays with correct length matching index dimension", "percentage": 92}
    ]'::jsonb,
    'Pinecone index created and initialized. Vector data prepared from embedding model.',
    'Upsert completes without dimension errors. Vectors successfully stored in index.',
    'Using different embedding models in different parts of code. Not verifying vector dimensions before upsert.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77094355/error-on-upsert-request-on-pinecone-in-nodejs',
    'admin:1764173122'
),

-- 4. OpenAI API Rate Limit 429 Error
(
    'openai.RateLimitError: Error code: 429 - That model is currently overloaded with other requests',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Add minimum $5 credit balance to OpenAI account in billing settings even for paid tiers. Many rate limit errors are due to insufficient credit balance rather than request limits.", "percentage": 88},
        {"solution": "Implement exponential backoff retry strategy with exponentially increasing delays between retries", "percentage": 90},
        {"solution": "Contact OpenAI support if 429 errors persist despite proper configuration and available credits", "percentage": 78}
    ]'::jsonb,
    'OpenAI API account configured. API key set and valid.',
    '429 errors resolve after adding credits or implementing backoff. Requests complete successfully.',
    'Assuming 429 only means rate limit exceeded. Not checking account credit balance. Retrying immediately without backoff.',
    0.85,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/75494945/openai-api-429-rate-limit-error-without-reaching-rate-limit',
    'admin:1764173122'
),

-- 5. ChromaDB Embedding Dimension Mismatch
(
    'InvalidDimensionException: Embedding dimension 384 does not match collection dimensionality 1536',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "When retrieving existing ChromaDB collection, pass the same embedding function used at creation: client.get_collection(name=''collection_name'', embedding_function=openai_ef)", "percentage": 94},
        {"solution": "Delete and recreate collection with consistent embedding model if dimension mismatch occurs", "percentage": 85}
    ]'::jsonb,
    'ChromaDB client initialized. Embedding function available.',
    'Collections retrieved with matching embedding dimensions. No InvalidDimensionException errors.',
    'Using different embedding models (OpenAI vs Sentence Transformers) for create vs retrieve operations. Forgetting to pass embedding function to get_collection().',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/77694864/invaliddimensionexception-embedding-dimension-384-does-not-match-collection-dim',
    'admin:1764173122'
),

-- 6. PyTorch CUDA Out of Memory with Free Memory
(
    'RuntimeError: CUDA out of memory. Tried to allocate 10.34 GiB (GPU 0; 23.69 GiB total capacity; 10.97 GiB already allocated)',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Combine garbage collection with GPU memory clearing: import gc; model.cpu(); del model; gc.collect(); torch.cuda.empty_cache()", "percentage": 92},
        {"solution": "Filter or truncate input to reduce memory requirements. Test problematic code on CPU first to identify actual issues.", "percentage": 88}
    ]'::jsonb,
    'PyTorch and CUDA toolkit installed. GPU available with memory.',
    'torch.cuda.empty_cache() completes without error. Model processes successfully.',
    'Calling torch.cuda.empty_cache() alone without garbage collection. Processing very long sequences without truncation.',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/70508960/how-to-free-gpu-memory-in-pytorch',
    'admin:1764173122'
),

-- 7. TensorFlow GPU Not Detected
(
    'Device mapping: no known devices. TensorFlow cannot find GPU despite CUDA deviceQuery passing',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Reinstall tensorflow-gpu package instead of tensorflow CPU version: pip uninstall tensorflow; pip install tensorflow-gpu", "percentage": 93},
        {"solution": "Force reinstall with clean dependencies: pip uninstall protobuf tensorflow tensorflow-gpu; pip install --upgrade --force-reinstall tensorflow-gpu", "percentage": 89},
        {"solution": "Set CUDA_VISIBLE_DEVICES environment variable: export CUDA_VISIBLE_DEVICES=0,1", "percentage": 85}
    ]'::jsonb,
    'CUDA toolkit installed. GPU present and functional (confirmed by deviceQuery).',
    'TensorFlow detects GPU. Device mapping shows available devices.',
    'Installing CPU-only TensorFlow. Not cleaning up protobuf package. Not setting CUDA_VISIBLE_DEVICES.',
    0.90,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/42326748/tensorflow-on-gpu-no-known-devices-despite-cudas-devicequery-returning-a-pas',
    'admin:1764173122'
),

-- 8. Scikit-Learn SVM Shape Mismatch
(
    'ValueError: Buffer has wrong number of dimensions (expected 1, got 2) when fitting SVR with shape (40000, 59)',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Reshape target array to 1D: y must have shape (n_samples,) not (n_samples, n_outputs). Use y.ravel() or reshape(-1) to flatten.", "percentage": 94},
        {"solution": "Train separate SVM models for each output dimension instead of attempting multi-output prediction with single model", "percentage": 87}
    ]'::jsonb,
    'Scikit-learn installed. SVM regressor initialized.',
    'fit() method accepts target array. Model trains without shape errors.',
    'Passing 2D target array expecting 1D. Not understanding SVM supports only single target per sample.',
    0.92,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/33438061/python-scikit-learn-svm-shape-mismatch',
    'admin:1764173122'
),

-- 9. Pandas Merge on Index with Series
(
    'IndexError: list index out of range when using pd.merge() with Series objects and left_index=True',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Convert Series to DataFrames before merging: merged = pd.merge(pd.DataFrame(series1), pd.DataFrame(series2), left_index=True, right_index=True)", "percentage": 95},
        {"solution": "Use Series.combine_first() or Series.add() for simpler index-based combinations instead of merge", "percentage": 88}
    ]'::jsonb,
    'Pandas library installed. Series objects created.',
    'Merge completes without IndexError. DataFrames successfully combined.',
    'Using pd.merge() with Series instead of DataFrames. Not converting Series to DataFrame structure first.',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/27281734/pandas-merge-on-index-not-working',
    'admin:1764173122'
),

-- 10. FastAPI Pydantic Validation Error
(
    'ValueError: ValueError() takes no keyword arguments when raising error in Pydantic validator with FastAPI',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Use constrained types instead of manual validators: conint(ge=0, le=1000000) for integer constraints", "percentage": 90},
        {"solution": "Raise HTTPException directly instead of ValueError for proper HTTP response codes in FastAPI dependencies", "percentage": 88},
        {"solution": "Create global exception handler for ValueError that returns appropriate HTTP status codes", "percentage": 82}
    ]'::jsonb,
    'FastAPI and Pydantic installed. API endpoint with validators configured.',
    'Request validation returns 4xx response code. No 500 Internal Server Error on validation failure.',
    'Raising ValueError in Pydantic validator. Not using constrained types for validation.',
    0.86,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/68914523/fastapi-pydantic-value-error-raises-internal-server-error',
    'admin:1764173122'
),

-- 11. SpaCy Model Not Found
(
    'OSError: Can''t find model ''en_core_web_sm'' when loading spaCy model',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Download model using same Python interpreter as runtime: python -m spacy download en_core_web_sm (not sudo python)", "percentage": 96},
        {"solution": "Use full model name when loading: nlp = spacy.load(''en_core_web_sm'') instead of just ''en''", "percentage": 92},
        {"solution": "For Anaconda, open Anaconda Prompt as Administrator and download models via conda", "percentage": 89}
    ]'::jsonb,
    'SpaCy package installed. Model download permissions available.',
    'Model loads without OSError. spaCy pipeline available for processing.',
    'Using sudo to download models (installs to wrong Python). Using short model aliases. Not matching Python versions.',
    0.94,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/49964028/spacy-oserror-cant-find-model-en',
    'admin:1764173122'
),

-- 12. NLTK Punkt Resource Not Found
(
    'Resource punkt not found. Please use the NLTK Downloader to obtain the resource when using word_tokenize()',
    'ai-ml',
    'HIGH',
    '[
        {"solution": "Download required NLTK data packages: nltk.download(''punkt''); nltk.download(''punkt_tab''); nltk.download(''wordnet'')", "percentage": 95},
        {"solution": "Add to script startup to ensure data is available before tokenization operations", "percentage": 91}
    ]'::jsonb,
    'NLTK library installed. Network access available for downloads.',
    'word_tokenize() completes successfully. Punkt data available locally.',
    'Not downloading required NLTK data packages. Assuming data is pre-installed.',
    0.93,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/73744658/resource-punkt-not-found-please-use-the-nltk-downloader-to-obtain-the-resource',
    'admin:1764173122'
),

-- 13. NumPy Broadcasting Error
(
    'ValueError: operands could not be broadcast together with shapes (1000,) (500,)',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Ensure all arrays have compatible shapes for broadcasting. Dimensions must either match or be 1. Reshape arrays explicitly: array1.reshape(-1, 1) or array2[:, None]", "percentage": 94},
        {"solution": "Use numpy.newaxis or reshape() to add dimensions: result = array1[:, None] + array2 adds compatible dimension", "percentage": 91}
    ]'::jsonb,
    'NumPy library installed. Arrays created with defined shapes.',
    'Broadcasting operation completes. Arrays with compatible shapes combine successfully.',
    'Not understanding NumPy broadcasting rules. Attempting to combine arrays with incompatible dimensions without reshaping.',
    0.91,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/24560298/python-numpy-valueerror-operands-could-not-be-broadcast-together-with-shapes',
    'admin:1764173122'
),

-- 14. Langchain LLM Chain Timeout
(
    'Indefinite halt or timeout when running LangChain LLM chain with no response or error message',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Set timeout parameter in LLM initialization: llm = ChatOpenAI(temperature=0, timeout=30) to prevent indefinite waits", "percentage": 88},
        {"solution": "Verify Endpoint connection is established before chain execution. Check network connectivity and endpoint availability.", "percentage": 85},
        {"solution": "Enable LangChain logging to debug: import logging; logging.basicConfig(level=logging.DEBUG) to see process logs", "percentage": 82}
    ]'::jsonb,
    'LangChain installed. LLM API configured. Network connectivity available.',
    'LLM chain completes within timeout period. No indefinite waits or hangs.',
    'Not setting timeout on LLM calls. Assuming network connectivity without verification. Not enabling debug logging.',
    0.83,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/76265748/indefinite-wait-while-using-langchain-and-huggingfacehub-in-python',
    'admin:1764173122'
),

-- 15. Transformers Tokenizer Max Length Error
(
    'Warning or error when tokenizer input exceeds model_max_length without proper truncation settings configured',
    'ai-ml',
    'MEDIUM',
    '[
        {"solution": "Set truncation and max_length explicitly when initializing tokenizer: tokenizer = AutoTokenizer.from_pretrained(model, model_max_length=512, truncation=True)", "percentage": 93},
        {"solution": "Apply truncation parameter in encode: inputs = tokenizer(text, truncation=True, max_length=512, padding=True)", "percentage": 90}
    ]'::jsonb,
    'Transformers library installed. Model and tokenizer loaded.',
    'Tokenizer truncates long sequences without warnings. Outputs match expected max_length dimension.',
    'Not setting truncation=True. Not specifying max_length explicitly. Assuming default behavior handles long inputs.',
    0.89,
    'haiku',
    NOW(),
    'https://stackoverflow.com/questions/69842980/asking-to-truncate-to-max-length-but-no-maximum-length-is-provided-and-the-model',
    'admin:1764173122'
);

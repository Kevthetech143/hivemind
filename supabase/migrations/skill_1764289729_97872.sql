-- Skills migration: GitLab CI, Bats Testing, LangChain, DeFi Protocols
-- Generated: 2025-11-27

INSERT INTO knowledge_entries (query, category, type, solutions, executable_type, prerequisites, common_pitfalls, success_indicators, preview_summary, source_url, contributor_email)
VALUES (
  'GitLab CI Patterns - Build CI/CD pipelines with multi-stage workflows, caching, and runners',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Basic Pipeline Structure",
      "manual": "Create multi-stage GitLab CI pipeline with build, test, deploy stages. Configure caching for node_modules, artifacts for dist/ outputs, and coverage reports. Use node:20 image and implement proper expire_in policies."
    },
    {
      "solution": "Docker Build and Push",
      "manual": "Build Docker images with docker:24-dind service. Login to registry, build with commit SHA and latest tags, push both versions. Configure for main branch and tags only."
    },
    {
      "solution": "Multi-Environment Deployment",
      "manual": "Use deploy template anchors for staging and production environments. Configure kubectl context with server, token, credentials. Use manual gates for production deployments."
    },
    {
      "solution": "Terraform Pipeline",
      "manual": "Setup validate, plan, apply stages. Use hashicorp/terraform image. Run init, validate, fmt check, plan with output artifact, apply with manual gate. Implement dependencies between stages."
    },
    {
      "solution": "Security Scanning",
      "manual": "Include SAST, Dependency, Container scanning templates. Add Trivy image scanning for registry images. Set exit code 1 for HIGH/CRITICAL severity. Allow failure for non-blocking scans."
    }
  ]'::jsonb,
  'steps',
  'GitLab repository, GitLab Runners configured, kubectl access (for Kubernetes deployments), Docker registry credentials',
  'Using node:latest instead of specific version, not setting artifact expiration, missing cache policies, not implementing manual gates for production, incorrect TLS_CERTDIR configuration',
  'Pipeline runs without errors, coverage reports generated, Docker images pushed successfully, Kubernetes deployments rollout status shows success, Terraform plan creates execution plan without manual intervention',
  'Multi-stage GitLab CI pipelines with Docker builds, Kubernetes deployments, Terraform IaC, security scanning, and caching strategies',
  'https://skillsmp.com/skills/wshobson-agents-plugins-cicd-automation-skills-gitlab-ci-patterns-skill-md',
  'admin:HAIKU_SKILL_1764289729_97872'
),
(
  'Bats Testing Patterns - Master Bash Automated Testing System for shell script testing',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Installation and Setup",
      "cli": {"macos": "brew install bats-core", "linux": "git clone https://github.com/bats-core/bats-core.git && cd bats-core && ./install.sh /usr/local", "windows": "npm install --global bats"},
      "manual": "Verify installation with bats --version. Create project structure with bin/, tests/, tests/fixtures/, and tests/helpers/ directories."
    },
    {
      "solution": "Basic Test Structure",
      "manual": "Create test files with @test blocks. Implement setup() and teardown() functions for each test. Use run command to capture exit status and output. Assert on $status and $output variables."
    },
    {
      "solution": "Assertion Patterns",
      "manual": "Test exit codes with [ \"$status\" -eq 0 ]. Test output with [ \"$output\" = \"expected\" ]. Use $lines array for multi-line output. Test file existence with [ -f \"file\" ]. Use regex matching with [[ $output =~ pattern ]]."
    },
    {
      "solution": "Mocking and Stubbing",
      "manual": "Create stub directory in TMPDIR. Write mock scripts and add to PATH. Override functions with export -f. Create dynamic stubs that return specified output and exit codes."
    },
    {
      "solution": "Fixture Management",
      "manual": "Store test data in tests/fixtures/ directory. Use setup() to copy fixtures to work directory. Generate dynamic fixtures with loops. Compare outputs against expected fixture files."
    },
    {
      "solution": "CI/CD Integration",
      "cli": {"bash": "bats tests/*.bats", "github": "npm install --global bats && bats tests/*.bats", "makefile": "test:\n\tbats tests/*.bats"},
      "manual": "Add bats to GitHub Actions workflow. Create Makefile targets for test, test-verbose, test-tap, test-parallel. Output TAP format for reporting."
    }
  ]'::jsonb,
  'script',
  'Bash shell, bats-core installed, test files with .bats extension, helper scripts for complex tests',
  'Not cleaning up temporary files in teardown(), testing only happy path without error conditions, hardcoding paths instead of using BATS_TEST_DIRNAME, not mocking external dependencies, running sequential tests that should be parallel',
  'All tests pass with TAP output, temporary files cleaned up after teardown, exit codes and output properly captured and asserted, mocked dependencies work correctly, fixtures generate expected outputs, CI/CD pipeline runs tests successfully',
  'Comprehensive Bats testing framework for shell scripts with setup/teardown, mocking, fixtures, and CI/CD integration patterns',
  'https://skillsmp.com/skills/wshobson-agents-plugins-shell-scripting-skills-bats-testing-patterns-skill-md',
  'admin:HAIKU_SKILL_1764289729_97872'
),
(
  'LangChain Architecture - Design LLM applications with agents, memory, and tool integration',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Initialize Agent with Tools and Memory",
      "cli": {"python": "pip install langchain openai"},
      "manual": "Create LLM instance with OpenAI(temperature=0). Load tools with load_tools([\"serpapi\", \"llm-math\"]). Initialize ConversationBufferMemory with memory_key. Use initialize_agent() with AgentType.CONVERSATIONAL_REACT_DESCRIPTION. Run queries with agent.run()."
    },
    {
      "solution": "Implement RAG Pipeline",
      "manual": "Load documents with TextLoader or DirectoryLoader. Split with CharacterTextSplitter(chunk_size=1000, chunk_overlap=200). Create embeddings with OpenAIEmbeddings(). Store in Chroma vector store. Create RetrievalQA chain with return_source_documents=True."
    },
    {
      "solution": "Create Custom Tools with @tool Decorator",
      "manual": "Define tools with @tool decorator. Provide clear docstrings explaining tool purpose. Return formatted strings from tool functions. Register tools in list for agent initialization. Tools become available for agent decision-making."
    },
    {
      "solution": "Build Multi-Step Sequential Chains",
      "manual": "Create multiple LLMChain instances with PromptTemplate. Define input_variables and templates for each chain. Combine with SequentialChain specifying chains, input_variables, output_variables. Set verbose=True for debugging."
    },
    {
      "solution": "Configure Memory Management",
      "manual": "Use ConversationBufferMemory for short chats (< 10 messages). Use ConversationSummaryMemory with llm for long conversations. Use ConversationBufferWindowMemory(k=5) for sliding window. Use ConversationEntityMemory for entity tracking."
    },
    {
      "solution": "Implement Custom Callbacks",
      "manual": "Extend BaseCallbackHandler. Implement on_llm_start, on_llm_end, on_llm_error, on_chain_start, on_agent_action methods. Print or log relevant information. Pass callbacks=[CustomCallbackHandler()] to agent.run()."
    },
    {
      "solution": "Optimize Performance with Caching and Streaming",
      "manual": "Set langchain.llm_cache = InMemoryCache() for caching. Use ThreadPoolExecutor for batch document processing. Enable streaming with OpenAI(streaming=True, callbacks=[StreamingStdOutCallbackHandler()])."
    }
  ]'::jsonb,
  'script',
  'Python 3.8+, LangChain installed, OpenAI API key, langchain[openai] dependencies',
  'Not managing conversation memory length causing token overflow, poor tool descriptions confusing agent, exceeding context window, missing error handling in agent execution, inefficient vector store queries, not testing with mock LLMs',
  'Agent successfully selects and uses appropriate tools, memory variables persist across interactions, RAG pipeline returns relevant documents with sources, sequential chains execute all steps in order, callbacks log all events, token usage stays within limits',
  'LangChain framework for autonomous AI agents with ReAct reasoning, conversation memory management, document retrieval, and tool integration patterns',
  'https://skillsmp.com/skills/wshobson-agents-plugins-llm-application-dev-skills-langchain-architecture-skill-md',
  'admin:HAIKU_SKILL_1764289729_97872'
),
(
  'DeFi Protocol Templates - Implement staking, AMMs, governance, lending, and flash loan systems',
  'claude-code',
  'skill',
  '[
    {
      "solution": "Staking Contract with Reward Distribution",
      "manual": "Create StakingRewards contract inheriting from ReentrancyGuard and Ownable. Define stakingToken and rewardsToken IERC20 interfaces. Implement updateReward modifier to update reward calculations. Implement stake(), withdraw(), getReward(), exit() functions. Use rewardRate for per-second reward distribution."
    },
    {
      "solution": "Automated Market Maker (AMM)",
      "manual": "Create SimpleAMM contract with token0, token1 reserves. Implement addLiquidity() with mint shares based on sqrt(amount0 * amount1). Implement removeLiquidity() with proportional token return. Implement swap() with 0.3% fee using formula: amountOut = (resOut * amountInWithFee) / (resIn + amountInWithFee)."
    },
    {
      "solution": "Governance Token and Governor",
      "manual": "Create GovernanceToken extending ERC20Votes with permit support. Override _afterTokenTransfer, _mint, _burn calling super. Create Governor contract managing proposals. Implement propose() checking proposalThreshold. Implement vote() during votingPeriod. Implement execute() when forVotes > againstVotes."
    },
    {
      "solution": "Flash Loan System",
      "manual": "Create FlashLoanProvider contract with token and feePercentage. Implement flashLoan() that transfers amount, executes IFlashLoanReceiver callback, verifies repayment with fee. Create FlashLoanReceiver extending IFlashLoanReceiver. Implement executeOperation() decoding params and approving repayment."
    },
    {
      "solution": "Lending Protocol Patterns",
      "manual": "Structure lending contracts with deposit/withdrawal for liquidity providers. Implement borrow/repay for borrowers with collateral requirements. Calculate interest using accumulated rate model. Check health factor before liquidation. Use nonReentrant guard for critical functions."
    },
    {
      "solution": "Security and Best Practices",
      "manual": "Use OpenZeppelin libraries for token standards and access control. Implement ReentrancyGuard for external calls. Add event logging for all state changes. Include emergency pause mechanisms. Implement timelocks for governance decisions. Use checked arithmetic or SafeMath."
    }
  ]'::jsonb,
  'steps',
  'Solidity 0.8.0+, OpenZeppelin contracts library, Ethereum test environment (Hardhat/Truffle), ERC20 token implementation, security audit tools',
  'Missing ReentrancyGuard on external functions, improper reserve update sequences in AMM, insufficient collateral checks in lending, governance without timelocks, not implementing fee mechanisms, not testing flash loan attacks',
  'Staking contract distributes rewards correctly per-second, AMM maintains constant product formula, governance votes execute when quorum reached, flash loans repaid with fees in same transaction, lending protocol enforces collateral ratios, all contracts pass security audits',
  'Production-ready DeFi protocol templates for staking rewards, AMM liquidity pools, governance voting, flash loans, and lending systems with OpenZeppelin security patterns',
  'https://skillsmp.com/skills/wshobson-agents-plugins-blockchain-web3-skills-defi-protocol-templates-skill-md',
  'admin:HAIKU_SKILL_1764289729_97872'
);

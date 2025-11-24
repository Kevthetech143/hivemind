#!/usr/bin/env node
/**
 * Transform GitHub issues to clauderepo KB format
 * Usage: node transform-issues-to-kb.js <input.json> <output.json>
 */

const fs = require('fs');

const INPUT_FILE = process.argv[2];
const OUTPUT_FILE = process.argv[3] || 'clauderepo-entries.json';

if (!INPUT_FILE) {
  console.error('Usage: node transform-issues-to-kb.js <input.json> [output.json]');
  process.exit(1);
}

console.log(`📖 Reading ${INPUT_FILE}...`);
const issues = JSON.parse(fs.readFileSync(INPUT_FILE, 'utf8'));

console.log(`Found ${issues.length} issues`);

// Filter issues with solutions (has comments)
const withSolutions = issues.filter(issue =>
  issue.comments && issue.comments.length > 0
);

console.log(`Issues with comments: ${withSolutions.length}`);

const entries = [];
let skipped = 0;

for (const issue of withSolutions) {
  // Skip if no body or empty
  if (!issue.body || issue.body.trim().length < 20) {
    skipped++;
    continue;
  }

  // Infer category from labels
  const labelNames = issue.labels.map(l => l.name);
  let category = 'general';

  if (labelNames.includes('area:mcp')) category = 'mcp-troubleshooting';
  else if (labelNames.includes('area:automation')) category = 'web-automation';
  else if (labelNames.includes('area:api')) category = 'api';
  else if (labelNames.includes('platform:macos')) category = 'macos';
  else if (labelNames.includes('platform:windows')) category = 'windows';
  else if (labelNames.includes('area:permissions')) category = 'security';

  // Extract problem from title + first part of body
  const query = issue.title.replace(/^\[BUG\]\s*/i, '').replace(/^\[FEATURE\]\s*/i, '');

  // Get last comment as solution (usually the fix/close reason)
  const lastComment = issue.comments[issue.comments.length - 1];
  const solutionText = lastComment?.body || '';

  // Skip if solution is too short or just "fixed in version X"
  if (solutionText.length < 30 || /^fixed in /i.test(solutionText)) {
    skipped++;
    continue;
  }

  // Check for code blocks in solution
  const codeBlockMatch = solutionText.match(/```[\s\S]*?```/);
  const hasCode = !!codeBlockMatch;

  // Extract command if present
  let command = null;
  if (hasCode) {
    command = codeBlockMatch[0]
      .replace(/```(\w+)?\n/, '')
      .replace(/```$/, '')
      .trim();
  }

  // Create solutions array
  const solutions = [{
    solution: solutionText.split('\n')[0].substring(0, 200), // First line, max 200 chars
    percentage: 85, // Default confidence
    command: hasCode ? command : undefined,
    note: `From GitHub issue #${issue.number}`
  }];

  // Build KB entry
  const entry = {
    query,
    category,
    solutions,
    prerequisites: 'Check GitHub issue for full context',
    success_indicators: 'Issue resolved, error no longer occurs',
    common_pitfalls: extractPitfalls(issue.body),
    success_rate: 0.85,
    claude_version: 'sonnet-4',
    last_verified: issue.closedAt || new Date().toISOString(),
    source: `github-issue-${issue.number}`,
    github_url: `https://github.com/anthropics/claude-code/issues/${issue.number}`
  };

  entries.push(entry);
}

// Extract common pitfalls from issue body
function extractPitfalls(body) {
  if (!body) return '';

  // Look for "Note:", "Warning:", "Important:" sections
  const noteMatch = body.match(/(?:Note|Warning|Important|Gotcha):?\s*(.+?)(?:\n\n|\n-|\n\*|$)/i);
  if (noteMatch) {
    return noteMatch[1].trim().substring(0, 200);
  }

  return '';
}

console.log(`\n📊 Transform complete!`);
console.log(`━━━━━━━━━━━━━━━━━━━━━━━━━`);
console.log(`Total entries: ${entries.length}`);
console.log(`Skipped: ${skipped}`);
console.log(`\nCategory breakdown:`);

const categoryCounts = entries.reduce((acc, entry) => {
  acc[entry.category] = (acc[entry.category] || 0) + 1;
  return acc;
}, {});

Object.entries(categoryCounts)
  .sort((a, b) => b[1] - a[1])
  .forEach(([cat, count]) => {
    console.log(`  ${cat}: ${count}`);
  });

// Write output
fs.writeFileSync(OUTPUT_FILE, JSON.stringify(entries, null, 2));
console.log(`\n✅ Wrote ${entries.length} entries to ${OUTPUT_FILE}`);

// Show sample
console.log(`\nSample entry:`);
console.log(JSON.stringify(entries[0], null, 2));

console.log(`\nNext: Import with bulk insert script`);

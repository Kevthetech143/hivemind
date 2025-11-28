-- Migration: Add AWS CloudFront CDN Skill to Knowledge Base
-- Generated: 2025-11-28
-- Miner: admin:HAIKU_1764339545_22921

INSERT INTO knowledge_entries (
  query,
  category,
  type,
  solutions,
  executable_type,
  prerequisites,
  common_pitfalls,
  success_indicators,
  preview_summary,
  source_url,
  contributor_email
) VALUES (
  'AWS CloudFront CDN',
  'claude-code',
  'skill',
  '[{"solution": "Use AWS CLI to create CloudFront distributions with S3 origins, proper cache behaviors, and WAF integration for DDoS protection. Configure Origin Access Identity (OAI) to restrict S3 access.", "percentage": 90}, {"solution": "Deploy using Terraform with aws_cloudfront_distribution, aws_wafv2_web_acl, and cache policies for fine-grained control over edge locations and origin behavior.", "percentage": 85}]'::jsonb,
  'manual',
  'AWS account with S3 bucket; AWS CLI or Terraform; CloudFront and WAF services enabled',
  'Making S3 buckets public instead of using OAI; caching sensitive data; using HTTP instead of HTTPS; ignoring WAF protection; excessive cache invalidations',
  'CloudFront distribution created successfully; custom domain resolves to CloudFront endpoint; requests served from edge locations; WAF rules active; cache hit ratio improves performance',
  'Global content delivery using CloudFront with caching, security headers, WAF integration, and origin configuration for low-latency distribution.',
  'https://skillsmp.com/skills/aj-geddes-useful-ai-prompts-skills-aws-cloudfront-cdn-skill-md',
  'admin:HAIKU_1764339545_22921'
);

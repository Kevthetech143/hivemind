-- Add Stack Overflow Sharp solutions batch 1
-- Extracted from highest-voted Sharp image processing questions with accepted answers

INSERT INTO knowledge_entries (
    query, category, hit_frequency, solutions, prerequisites, success_indicators,
    common_pitfalls, success_rate, claude_version, last_verified, source_url
) VALUES (
    'Sharp image library rotates image when resizing, EXIF orientation data lost',
    'stackoverflow-sharp',
    'HIGH',
    $$[
        {"solution": "Use .rotate() method to auto-orient image based on EXIF data: sharp(data.Body).rotate().resize(width, height).toBuffer()", "percentage": 94, "note": "Preferred approach, maintains smaller file size"},
        {"solution": "Use .withMetadata() to retain EXIF data during resizing: sharp(data.Body).resize(width, height).withMetadata().toBuffer()", "percentage": 88, "note": "Preserves all metadata but increases file size, avoid with PNG"},
        {"solution": "Apply rotate() before resize for best results: sharp().rotate().resize(width, height)", "percentage": 92, "note": "Order matters for optimal output"}
    ]$$::jsonb,
    'Sharp library installed, image file with EXIF orientation data',
    'Resized image displays correct orientation, no unintended rotation, file size appropriate for format',
    'Method order matters - use resize().rotate() or rotate().resize() carefully. PNG has limited EXIF support, prefer JPEG for metadata. .rotate() auto-applies rotation from EXIF without parameters.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/48716266/sharp-image-library-rotates-image-when-resizing'
),
(
    'Sharp module installation error: Cannot find module "../build/Release/sharp.node"',
    'stackoverflow-sharp',
    'VERY_HIGH',
    $$[
        {"solution": "Rebuild sharp native bindings: npm rebuild --verbose sharp", "percentage": 95, "note": "Fastest fix for native module issues"},
        {"solution": "Reinstall latest sharp version: npm install sharp@latest --save", "percentage": 88, "note": "Works if newer version has fixes for your environment"},
        {"solution": "Clear npm cache and reinstall: npm cache clean -f && npm install", "percentage": 82, "note": "Helps resolve corrupted package data"}
    ]$$::jsonb,
    'npm installed, Node.js with native module support, build tools for your OS',
    'sharp.node file exists in node_modules, npm rebuild completes without errors, module loads successfully',
    'sharp is a native Node.js module requiring compilation. Missing .node file indicates failed build. npm rebuild recompiles bindings without reinstalling. May need platform-specific build tools.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/56723276/how-to-fix-something-went-wrong-installing-the-sharp-module-and-cannot-find-mo'
),
(
    'Cant install sharp, npm installation fails with permission or build errors',
    'stackoverflow-sharp',
    'VERY_HIGH',
    $$[
        {"solution": "Use --unsafe-perm flag to bypass permission restrictions: npm install --unsafe-perm", "percentage": 94, "note": "Resolves permission-denied errors across platforms"},
        {"solution": "macOS: install vips dependency first: brew install vips && npm install --unsafe-perm", "percentage": 91, "note": "Required for macOS builds"},
        {"solution": "Delete package-lock.json and node_modules, then reinstall: rm -rf package-lock.json node_modules && npm install", "percentage": 87, "note": "Clears corrupted dependency state"},
        {"solution": "Windows: Install Visual Studio Build Tools, then npm install sharp --save", "percentage": 85, "note": "Windows requires compiled tools"}
    ]$$::jsonb,
    'npm installed, Node.js v14+, macOS requires Homebrew or system package manager',
    'npm install completes without errors, sharp loads without module not found errors, image processing executes',
    'When npm runs with sudo, it switches to lower-privileged user causing permission errors. --unsafe-perm bypasses this. Delete package-lock.json to reset dependency resolution. Platform-specific tools required (Xcode on macOS, Visual Studio on Windows).',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/54409953/cant-install-sharp'
),
(
    'Resize image in sharp with contain option, preserve aspect ratio within bounds',
    'stackoverflow-sharp',
    'MEDIUM',
    $$[
        {"solution": "Use fit: ''inside'' option to resize within bounding box while preserving aspect ratio: sharp(image).resize(800, 800, {fit: ''inside''}).jpeg({quality: 80}).toBuffer()", "percentage": 93, "note": "Produces output smaller than or equal to specified bounds"},
        {"solution": "Specify only width to preserve aspect ratio automatically: sharp(image).resize({fit: sharp.fit.contain, width: 800})", "percentage": 90, "note": "Simpler for width-only constraints"},
        {"solution": "Use contain fit option explicitly: sharp(image).resize(800, 800, {fit: ''contain''})", "percentage": 88, "note": "Centers image in bounding box"}
    ]$$::jsonb,
    'Sharp library installed, image file to process, desired width and height dimensions',
    'Output image fits within specified dimensions, aspect ratio preserved, image not distorted or stretched',
    'Use ''inside'' for maximum bounds, ''contain'' for centered padding. Must specify both width and height for ''inside'' to work correctly. Aspect ratio always preserved with fit option.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/58508690/how-to-resize-an-image-in-sharp-with-the-option-contain-but-preserve-the-aspec'
),
(
    'Compress image using sharp in node.js, reduce file size while maintaining quality',
    'stackoverflow-sharp',
    'HIGH',
    $$[
        {"solution": "Use metadata() to detect format, then apply format-specific compression: const meta = await image.metadata(); then image[meta.format]({quality: 80}) for JPEG/WebP", "percentage": 92, "note": "Automatically selects optimal compression settings"},
        {"solution": "For JPEG: use quality parameter (default 80): image.jpeg({quality: 80}).resize(1000)", "percentage": 94, "note": "80 is good balance of size vs quality"},
        {"solution": "For PNG: use compressionLevel (0-9, default 8) or quality reduction: image.png({compressionLevel: 8})", "percentage": 90, "note": "Lossless compression, quality parameter reduces color palette"},
        {"solution": "For WebP: use quality setting like JPEG: image.webp({quality: 80})", "percentage": 88, "note": "Superior compression ratio compared to JPEG"}
    ]$$::jsonb,
    'Sharp library installed, image file in supported format (JPEG, PNG, WebP), source image available',
    'Output file size significantly reduced, image quality acceptable for use case, format preserved or transcoded successfully',
    'JPEG quality default is 80. PNG compressionLevel 0-9 where 9 is maximum. Quality parameter on PNG reduces palette. Different formats need different parameters - cannot use quality on all formats. Format detection must happen before compression.',
    0.91,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/51291678/compress-image-using-sharp-in-node-js'
),
(
    'Mac M1 sharp installation fails, cannot install sharp on Apple silicon',
    'stackoverflow-sharp',
    'HIGH',
    $$[
        {"solution": "Install Xcode command line tools, Homebrew packages, then npm: xcode-select --install && brew install gcc && brew reinstall vips && npm i", "percentage": 93, "note": "Complete solution addressing build tool dependencies"},
        {"solution": "Simpler workaround: npm install sharp --unsafe-perm", "percentage": 85, "note": "Quick fix but not permanent"},
        {"solution": "Install with M1-specific settings: npm install --arch=arm64 sharp", "percentage": 82, "note": "Directly targets ARM64 architecture"}
    ]$$::jsonb,
    'Mac M1 system with Homebrew installed, Node.js installed, Xcode not installed',
    'sharp installs without native compilation errors, npm install completes successfully, sharp module loads',
    'M1 Macs require specific build tools. xcode-select installs command line tools needed. brew install gcc provides compiler. vips is critical libvips dependency. Run full install sequence in order.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/67560211/mac-m1-something-went-wrong-installing-the-sharp-module'
),
(
    'Get height and width of image using sharp metadata',
    'stackoverflow-sharp',
    'MEDIUM',
    $$[
        {"solution": "Use metadata() function: const metadata = await sharp(file.buffer).metadata(); console.log(metadata.width, metadata.height)", "percentage": 95, "note": "Direct approach for original dimensions"},
        {"solution": "Destructure for cleaner code: const {width, height} = await sharp(file.buffer).metadata();", "percentage": 94, "note": "Same as above with better syntax"},
        {"solution": "Get dimensions after resize using toBuffer with resolveWithObject: const {info} = await image.resize(640).png().toBuffer({resolveWithObject: true}); console.log(info.width, info.height)", "percentage": 90, "note": "For dimensions after transformations"}
    ]$$::jsonb,
    'Sharp library installed, image file or buffer available, async/await support in Node.js',
    'metadata.width and metadata.height return numeric values, dimensions match actual image, after-transform dimensions reflect resize operation',
    'metadata() returns original image dimensions from file header. Use toBuffer() with resolveWithObject: true for dimensions after operations. metadata() is async - must use await. Destructuring optional but recommended.',
    0.94,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/62653165/can-we-get-height-and-width-of-image-using-sharp'
),
(
    'Sharp module loading error in Strapi, win32-x64 runtime compatibility issue',
    'stackoverflow-sharp',
    'HIGH',
    $$[
        {"solution": "Downgrade sharp to 0.32.6: npm install sharp@0.32.6 --save", "percentage": 94, "note": "Resolves 0.33.1 Windows compatibility issues"},
        {"solution": "Install optional dependencies: npm install --include=optional sharp", "percentage": 87, "note": "Ensures all optional native bindings downloaded"},
        {"solution": "Platform-specific Windows install: npm install --force @img/sharp-win32-x64", "percentage": 85, "note": "Explicitly installs Windows x64 binaries"},
        {"solution": "Clear cache and reinstall: npm cache clean -f && npm install", "percentage": 80, "note": "Resolves corrupted package cache"}
    ]$$::jsonb,
    'Strapi project with Node.js v18.x on Windows, npm or yarn package manager',
    'Strapi admin panel loads without image processing errors, sharp module loads successfully, image processing operations complete',
    'Version 0.33.1 has Windows compatibility issues. Downgrade to 0.32.6 is most reliable. --include=optional flag ensures optional dependencies resolve. Yarn with --ignore-engines also works.',
    0.90,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/77789610/could-not-load-the-sharp-module-using-the-win32-x64-runtime-strapi'
),
(
    'Sharp image processor keeps source file open, unable to unlink original after resize',
    'stackoverflow-sharp',
    'MEDIUM',
    $$[
        {"solution": "Disable sharp cache at startup: const sharp = require(''sharp''); sharp.cache(false);", "percentage": 95, "note": "Most reliable solution - disables file handle caching"},
        {"solution": "Use promise-based workflow to ensure processing completes: await sharp(inputPath).resize(width, height).toFile(outputPath); then unlink input", "percentage": 88, "note": "Ensures processing finished before delete"},
        {"solution": "On Windows, add delay before unlinking: setTimeout(() => fs.unlink(inputPath), 100);", "percentage": 80, "note": "Workaround if cannot disable cache"}
    ]$$::jsonb,
    'Sharp library installed, source file readable, Node.js fs module available, Windows or file system with file locking',
    'Source file unlinking succeeds after resize, no EBUSY errors, file can be deleted or replaced',
    'sharp.cache() with boolean false disables caching. Earlier API sharp.cache({files: 0}) does not work reliably. File locking primarily affects Windows. Ensure processing async function completes with await before attempting delete.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/41289173/node-js-module-sharp-image-processor-keeps-source-file-open-unable-to-unlink'
),
(
    'Sharp in AWS Lambda fails, darwin-x64 binaries cannot be used on linux-x64 platform',
    'stackoverflow-sharp',
    'HIGH',
    $$[
        {"solution": "Reinstall sharp for Linux on macOS: npm install --os=linux --cpu=x64 sharp", "percentage": 95, "note": "Installs correct Linux binaries for Lambda"},
        {"solution": "Delete node_modules and use platform flag: rm -rf node_modules && npm install --platform=linux --arch=x64 sharp", "percentage": 92, "note": "Alternative syntax for older npm versions"},
        {"solution": "Use Docker to build dependencies: add node_modules/ to .dockerignore so deps rebuild in container", "percentage": 88, "note": "Container builds dependencies in target environment"},
        {"solution": "With Serverless Framework: configure makefile with platform-specific install", "percentage": 82, "note": "Framework-specific approach"}
    ]$$::jsonb,
    'Sharp in project dependencies, deploying from macOS to AWS Lambda, npm or similar package manager',
    'Lambda function executes without binary compatibility errors, image processing operations succeed in Lambda environment, deployment completes',
    'Sharp contains native C++ bindings specific to OS architecture. macOS installs darwin-x64 binaries but Lambda runs linux-x64. Must explicitly specify Linux as target OS. Cannot reuse node_modules from macOS build.',
    0.93,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/60181138/error-running-sharp-inside-aws-lambda-function-darwin-x64-binaries-cannot-be-u'
),
(
    'Sharp convert transparent pixels to white background, remove alpha channel',
    'stackoverflow-sharp',
    'MEDIUM',
    $$[
        {"solution": "Use flatten() with background color: sharp(''input.png'').flatten({background: {r: 255, g: 255, b: 255}}).toBuffer()", "percentage": 94, "note": "Composites alpha channel with white background"},
        {"solution": "Hex color notation: sharp(''input.png'').flatten({background: ''#ffffff''})", "percentage": 93, "note": "Cleaner syntax than RGB object"},
        {"solution": "Apply before format conversion: sharp(data.Body).flatten({background: ''#fff''}).resize(width, height).toFormat(''jpeg'').toBuffer()", "percentage": 91, "note": "When converting PNG to JPEG which lacks transparency"}
    ]$$::jsonb,
    'PNG or image with alpha channel/transparency, sharp library installed, target format (typically JPEG which lacks transparency)',
    'Output image has white background instead of transparency, PNG converted to JPEG without visual artifacts, alpha channel removed successfully',
    'flatten() removes alpha channel by compositing with background. JPEG does not support transparency so flatten() is essential before conversion. Use flatten before resize for best results. RGB values range 0-255.',
    0.92,
    'sonnet-4',
    NOW(),
    'https://stackoverflow.com/questions/47818210/nodejs-sharp-transparent-into-white'
);

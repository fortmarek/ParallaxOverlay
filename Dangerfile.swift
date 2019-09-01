import Danger
import DangerSwiftCoverage // package: https://github.com/f-meloni/danger-swift-coverage.git
let danger = Danger()

let editedFiles = danger.git.modifiedFiles + danger.git.createdFiles
let editedAppFiles = editedFiles.filter { $0.contains("Sources") }

let hasSkipChangelog = danger.github.pullRequest.body?.contains("#no_changelog") ?? false
let hasSkipChangelogLabel = danger.github.issue.labels.first { $0.name == "Skip Changelog" } != nil
let skipCheck = hasSkipChangelog || hasSkipChangelogLabel

if editedAppFiles.count > 0 && !skipCheck {
  fail("Please add a CHANGELOG entry for these changes. You can find it at [CHANGELOG.md](https://github.com/fortmarek/ParallaxOverlay/blob/master/CHANGELOG.md). If you would like to skip this check, add `#no_changelog` to the PR body and re-run CI.")
}


let bigPRThreshold = 10
if ((danger.github.pullRequest.additions ?? 0) + (danger.github.pullRequest.deletions ?? 0) > bigPRThreshold) {
  warn("Pull Request size seems relatively large. If this Pull Request contains multiple changes, please split each into separate PR will helps faster, easier review.")
}

SwiftLint.lint(directory: "Sources", configFile: ".swiftlint.yml")

Coverage.xcodeBuildCoverage(.derivedDataFolder("Build"),
                            minimumCoverage: 50,
                            excludedTargets: ["DangerSwiftCoverageTests.xctest"])

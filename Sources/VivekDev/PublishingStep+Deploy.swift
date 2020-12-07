import Publish

extension PublishingStep where Site == VivekDev {
    static func deployToGitHub() -> Self {
        .deploy(using: .gitHub("vivekselvaraj/vivekselvaraj.github.io", useSSH: false))
    }
}

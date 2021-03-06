import CNAMEPublishPlugin
import Foundation
import Publish
import Plot

// This type acts as the configuration for your website.
struct VivekDev: Website {
    enum SectionID: String, WebsiteSectionID {
        // Add the sections that you want your website to contain here:
        case posts
    }

    struct ItemMetadata: WebsiteItemMetadata {
        // Add any site-specific metadata that you want to use here.
    }

    // Update these properties to configure your website:
    var url = URL(string: "https://vivek.dev")!
    var title = "Vivek Selvaraj"
    var name = "Vivek Selvaraj"
    var description = "Software Devleoper"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try VivekDev().publish(withTheme: .vannam, additionalSteps: [.installPlugin(
    .generateCNAME(with: "vivek.dev", "www.vivek.dev")),
    .deploy(using: .gitHub("vivekselvaraj/vivekselvaraj.github.io", useSSH: false))
])


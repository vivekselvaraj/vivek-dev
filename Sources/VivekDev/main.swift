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
    var name = "Vivek Selvaraj"
    var description = "Test Description"
    var language: Language { .english }
    var imagePath: Path? { nil }
}

// This will generate your website using the built-in Foundation theme:
try VivekDev().publish(using: [
                        .generateHTML(withTheme: .vannam),
                        .deploy(using: .gitHub("vivekselvaraj/vivekselvaraj.github.io"))
])

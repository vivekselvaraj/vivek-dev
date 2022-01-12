import CNAMEPublishPlugin
import DarkImagePublishPlugin
import Foundation
import MinifyCSSPublishPlugin
import Publish
import Plot
import SwiftPygmentsPublishPlugin

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
    var title = "Vivek"
    var name = "Vivek Selvaraj"
    var description = "Software Developer"
    var language: Language { .english }
    var imagePath: Path? { nil }
//    var favicon: Favicon? { .init(path: Path("images/favicon.ico"), type: "image/x-icon")}
}


try VivekDev().publish(using: [
    .copyResources(),
    .installPlugin(.generateCNAME(with: "vivek.dev", "www.vivek.dev")),
    .installPlugin(.darkImage()),
    .installPlugin(.pygments()),
    .addMarkdownFiles(),
    .generateHTML(withTheme: .vannam),
//    .installPlugin(.minifyCSS()),
    .generateRSSFeed(including: Set(VivekDev.SectionID.allCases)),
    .generateSiteMap(),
    .deploy(using: .gitHub("vivekselvaraj/vivekselvaraj.github.io"))
])


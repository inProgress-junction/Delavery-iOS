//
//  ShieldConfigurationExtension.swift
//  DelaverySheildConfiguration
//
//  Created by Inho Choi on 8/10/24.
//

import ManagedSettings
import ManagedSettingsUI
import UIKit

// Override the functions below to customize the shields used in various situations.
// The system provides a default appearance for any methods that your subclass doesn't override.
// Make sure that your class name matches the NSExtensionPrincipalClass in your Info.plist.
class ShieldConfigurationExtension: ShieldConfigurationDataSource {
    override func configuration(shielding application: Application) -> ShieldConfiguration {
        // Customize the shield as needed for applications.
        let title = "You haven't spent in the last 00 days.\nYou saved an average of 1,000,000 won!"
        return ShieldConfiguration(backgroundBlurStyle: .extraLight,
                                   backgroundColor: .white,
                                   icon: .applogo,
                                   title: .init(text: "", color: .clear),
                                   subtitle: .init(text: title, color: .black),
                                   primaryButtonLabel: .init(text: "Saving", color: .white),
                                   primaryButtonBackgroundColor: .lightBlue,
                                   secondaryButtonLabel: .init(text: "Consumption", color: .red)
        )
    }
    
    override func configuration(shielding application: Application, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for applications shielded because of their category.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain) -> ShieldConfiguration {
        // Customize the shield as needed for web domains.
        ShieldConfiguration()
    }
    
    override func configuration(shielding webDomain: WebDomain, in category: ActivityCategory) -> ShieldConfiguration {
        // Customize the shield as needed for web domains shielded because of their category.
        ShieldConfiguration()
    }
}

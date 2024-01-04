//
//  UserProfile.swift
//  GithubUserHomeProject
//
//  Created by talate on 5.11.2023.
//

import UIKit

// MARK: - UserProfile
struct UserProfile: Codable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type: String?
    let siteAdmin: Bool?
    let name, company: String?
    let blog: String?
    let location: String?
    let bio: String?
    let email: String?
    let hireable: Bool?
    let twitterUsername: String?
    let publicRepos, publicGists, followers, following: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
        case name, company, blog, location, email, hireable, bio
        case twitterUsername = "twitter_username"
        case publicRepos = "public_repos"
        case publicGists = "public_gists"
        case followers, following
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    ///MARK: Derived model for the user profile view's image section.
    var profileImageSection: UserProfileImageSection? {
        return UserProfileImageSection(imageURLString: avatarURL, name: name, username: login)
    }
    
    ///MARK: Derived models for the user profile view's info sections.
    var profileInfoSections: [UserProfileInfoSection] {
        var sections: [UserProfileInfoSection] = []
        
        if let followers = followers, let following = following {
            let followText = "\(followers) Followers / \(following) Following"
            sections.append(UserProfileInfoSection(icon: UIImage(named: "follow")!, text: followText))
        }
        
        if let email = email, !email.isEmpty {
            sections.append(UserProfileInfoSection(icon: UIImage(named: "email")!, text: email))
        }
        
        if let company = company, !company.isEmpty {
            sections.append(UserProfileInfoSection(icon: UIImage(named: "company")!, text: company))
        }
        
        if let location = location, !location.isEmpty {
            sections.append(UserProfileInfoSection(icon: UIImage(named: "location")!, text: location))
        }
        
        if let bio = bio, !bio.isEmpty {
            sections.append(UserProfileInfoSection(icon: UIImage(named: "bio")!, text: bio))
        }
        
        if let blog = blog, !blog.isEmpty {
            sections.append(UserProfileInfoSection(icon: UIImage(named: "blog")!, text: blog))
        }
        
        if let twitter = twitterUsername, !twitter.isEmpty {
            sections.append(UserProfileInfoSection(icon: UIImage(named: "twitter")!, text: twitter))
        }
        
        return sections
    }
    
    ///MARK: Derived model for the user profile view's footer section.
    var profileFooterSection: UserProfileFooterSection? {
        return UserProfileFooterSection(githubURLString: htmlURL, joinedDate: createdAt)
    }
}

// Model for the user profile image section
struct UserProfileImageSection {
    let imageURLString: String?
    let name: String?
    let username: String?
}

// Model for the sections displaying an icon and text
struct UserProfileInfoSection {
    let icon: UIImage
    let text: String
}

// Model for the sections displaying an icon and text
struct UserProfileFooterSection {
    let githubURLString: String?
    let joinedDate: String?
}

// Enumeration of sections in the user profile view.
enum UserProfileSection: Int, CaseIterable {
    case image = 0
    case info
    case footer
}

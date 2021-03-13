import Foundation

public struct AdvancedSuppressionManager: Codable {
    /// The unsubscribe group to associate with this email.
    public var groupId: Int
    
    /// An array containing the unsubscribe groups that you would like to be displayed on the unsubscribe preferences page.
    public var groupsToDisplay: [String]?
    
    public init(groupId: Int,
                groupsToDisplay: [String]? = nil) {
        self.groupId = groupId
        self.groupsToDisplay = groupsToDisplay
    }
    
    private enum CodingKeys: String, CodingKey {
        case groupId = "group_id"
        case groupsToDisplay = "groups_to_display"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(groupId, forKey: .groupId)
        try container.encode(groupsToDisplay, forKey: .groupsToDisplay)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        groupId = try container.decode(Int.self, forKey: .groupId)
        groupsToDisplay = try container.decodeIfPresent([String].self, forKey: .groupsToDisplay)
    }

}

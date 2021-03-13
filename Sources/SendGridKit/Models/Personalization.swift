import Foundation

public struct Personalization: Codable {
    
    /// From address used to deliver the email
    public var from: EmailAddress?
    
    /// An array of recipients. Each object within this array may contain the name, but must always contain the email, of a recipient.
    public var to: [EmailAddress]

    /// An array of recipients who will receive a copy of your email. Each object within this array may contain the name, but must always contain the email, of a recipient.
    public var cc: [EmailAddress]?

    /// An array of recipients who will receive a blind carbon copy of your email. Each object within this array may contain the name, but must always contain the email, of a recipient.
    public var bcc: [EmailAddress]?

    /// The subject of your email.
    public var subject: String?

    /// A collection of JSON key/value pairs allowing you to specify specific handling instructions for your email.
    public var headers: [String: String]?

    /// A collection of key/value pairs following the pattern "substitution_tag":"value to substitute".
    public var substitutions: [String: String]?
    
    /// A collection of key/value pairs following the pattern "key":"value" to substitute handlebar template data
    public var dynamicTemplateData: [String: String]?
    
    /// Values that are specific to this personalization that will be carried along with the email and its activity data.
    public var customArgs: [String: String]?
    
    /// A unix timestamp allowing you to specify when you want your email to be delivered. Scheduling more than 72 hours in advance is forbidden.
    public var sendAt: Date?
    
    public init(from: EmailAddress? = nil,
                to: [EmailAddress],
                cc: [EmailAddress]? = nil,
                bcc: [EmailAddress]? = nil,
                subject: String? = nil,
                headers: [String: String]? = nil,
                substitutions: [String: String]? = nil,
                dynamicTemplateData: [String: String]? = nil,
                customArgs: [String: String]? = nil,
                sendAt: Date? = nil) {
        self.from = from
        self.to = to
        self.cc = cc
        self.bcc = bcc
        self.subject = subject
        self.headers = headers
        self.substitutions = substitutions
        self.dynamicTemplateData = dynamicTemplateData
        self.customArgs = customArgs
        self.sendAt = sendAt
    }
    
    private enum CodingKeys: String, CodingKey {
        case from
        case to
        case cc
        case bcc
        case subject
        case headers
        case substitutions
        case customArgs = "custom_args"
        case dynamicTemplateData = "dynamic_template_data"
        case sendAt = "send_at"
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(from, forKey: .from)
        try container.encode(to, forKey: .to)
        try container.encode(cc, forKey: .cc)
        try container.encode(bcc, forKey: .bcc)
        try container.encode(subject, forKey: .subject)
        try container.encode(headers, forKey: .headers)
        try container.encode(substitutions, forKey: .substitutions)
        try container.encode(customArgs, forKey: .customArgs)
        try container.encode(dynamicTemplateData, forKey: .dynamicTemplateData)
        try container.encode(sendAt, forKey: .sendAt)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        from = try container.decodeIfPresent(EmailAddress.self, forKey: .from)
        to = try container.decode([EmailAddress].self, forKey: .to)
        cc = try container.decodeIfPresent([EmailAddress].self, forKey: .cc)
        bcc = try container.decodeIfPresent([EmailAddress].self, forKey: .bcc)
        subject = try container.decodeIfPresent(String.self, forKey: .subject)
        headers = try container.decodeIfPresent([String: String].self, forKey: .headers)
        substitutions = try container.decodeIfPresent([String: String].self, forKey: .substitutions)
        dynamicTemplateData = try container.decodeIfPresent([String: String].self, forKey: .dynamicTemplateData)
        customArgs = try container.decodeIfPresent([String: String].self, forKey: .customArgs)
        sendAt = try container.decodeIfPresent(Date.self, forKey: .sendAt)
    }
}

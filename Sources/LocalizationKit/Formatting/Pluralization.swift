public enum Pluralization {
    public static func suffix(for count: Int) -> String {
        switch count {
        case 0:
            "zero"
        case 1:
            "one"
        default:
            "other"
        }
    }
}

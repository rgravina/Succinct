internal extension UIView {
    func isLabel(withExactText searchText: String) -> EvaluationResult {
        if self.isUISegmentLabel() {
            return .failure(IsLabelWithExactTextResultType.wrongType)
        }

        guard let label = self as? UILabel else {
            return .failure(IsLabelWithExactTextResultType.wrongType)
        }

        guard let labelText = label.text else {
            return .failure(IsLabelWithExactTextResultType.noText(searchText: searchText))
        }

        guard labelText == searchText else {
            return .failure(IsLabelWithExactTextResultType.matchFailed(searchText: searchText, actualText: labelText))
        }

        guard label.isVisible else {
            return .failure(IsLabelWithExactTextResultType.hidden)
        }

        return .success(IsLabelWithExactTextResultType.found)
    }
}

internal enum IsLabelWithExactTextResultType: EvaluationResultType {
    case found
    case wrongType
    case noText(searchText: String)
    case matchFailed(searchText: String, actualText: String)
    case hidden

    var evaluatedMethod: String {
        get {
            return ""
        }
    }

    var resultMessage: String? {
        get {
            switch self {
            default:
                return nil
            }
        }
    }
}

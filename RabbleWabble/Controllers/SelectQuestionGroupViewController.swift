import UIKit
import SnapKit

public class SelectQuestionGroupViewController: UIViewController {

    // MARK: - Outlets
    internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView() //to prevent the table view from drawing unnecessary empty table view cells, which it does by default after all the other cells are drawn.
        }
    }

    // MARK: - Properties
    public let questionGroups = QuestionGroup.allGroups()
    private var selectedQuestionGroup: QuestionGroup!


    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Select Question Group"

        tableView = UITableView(frame: .zero, style: .plain)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }

        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(QuestionGroupCell.self, forCellReuseIdentifier: "QuestionGroupCell")
    }

}

// MARK: - UITableViewDataSource
extension SelectQuestionGroupViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView,
                          numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }

    public func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
        let questionGroup = questionGroups[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectQuestionGroupViewController: UITableViewDelegate{
    public func tableView(_ tableView: UITableView,
                          willSelectRowAt indexPath: IndexPath) -> IndexPath? {

        selectedQuestionGroup = questionGroups[indexPath.row]
        return indexPath
    }

    public func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
        let viewController = QuestionViewController()
        viewController.questionGroup = selectedQuestionGroup
        viewController.delegate = self
        navigationController?.pushViewController(viewController, animated: true)

        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - QuestionViewControllerDelegate
extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {

    public func questionViewController(_ viewController: QuestionViewController,
                                       didCancel questionGroup: QuestionGroup,
                                       at questionIndex: Int) {
        navigationController?.popToViewController(self,
                                                  animated: true)
    }

    public func questionViewController(_ viewController: QuestionViewController,
                                       didComplete questionGroup: QuestionGroup) {
        navigationController?.popToViewController(self,
                                                  animated: true)
    }
}

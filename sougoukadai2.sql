社員とプロジェクトに関するデータベースを設計し、以下の内容をSQLで作成してください。
以下の3つのテーブルを作成してください。

1. **employeesテーブル**（社員情報）
    - **カラム定義**:
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    position VARCHAR(50),
    salary INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

2. **projectsテーブル**（プロジェクト情報）
CREATE TABLE projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    budget INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

3. **assignmentsテーブル**（担当情報）
CREATE TABLE assignments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    project_id INT,
    hours INT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (employee_id) REFERENCES employees(id),
    FOREIGN KEY (project_id) REFERENCES projects(id)
);

**2. データの挿入**

以下のデータをSQLを使って挿入してください。

※`created_at` と`updated_at` については、作成日と更新日が挿入されるようにする

- **employeesテーブル**:
INSERT INTO employees(name, position, salary)
VALUES('山田太郎','マネージャー',700000),('佐藤花子','エンジニア',500000),('鈴木次郎','エンジニア',500000);

- **projectsテーブル**:
INSERT INTO projects(name, budget)
VALUES('新製品開発',10000000),('マーケティング戦略',5000000);

- **assignmentsテーブル**:
INSERT INTO assignments (employee_id, project_id, hours)
VALUES
(
  (SELECT id FROM employees WHERE name = '山田太郎'),
  (SELECT id FROM projects WHERE name = '新製品開発'),
  100
),
(
  (SELECT id FROM employees WHERE name = '佐藤花子'),
  (SELECT id FROM projects WHERE name = '新製品開発'),
  150
),
(
  (SELECT id FROM employees WHERE name = '鈴木次郎'),
  (SELECT id FROM projects WHERE name = 'マーケティング戦略'),
  200
);
---

**3. クエリの作成**

以下の内容を取得するSQL文を作成してください。

1. 全社員の情報を取得する。
 SELECT * FROM employees;

2. プロジェクトごとの割り当て時間の合計を取得する。
SELECT
  p.name AS project_name,
  SUM(a.hours) AS total_hours
FROM assignments a
JOIN projects p ON a.project_id = p.id
GROUP BY p.id, p.name;

3. 社員ごとの担当プロジェクト名と作業時間を取得する。
SELECT
  e.name AS employee_name,
  p.name AS project_name,
  a.hours
FROM assignments a
JOIN employees e ON a.employee_id = e.id
JOIN projects p ON a.project_id = p.id;

4. 作業時間が100時間以上の割り当てを取得する。
SELECT
  e.name AS employee_name,
  p.name AS project_name,
  a.hours
FROM assignments a
JOIN employees e ON a.employee_id = e.id
JOIN projects p ON a.project_id = p.id
WHERE a.hours >= 100;

5. 各プロジェクトの予算に対する作業時間あたりのコストを計算して取得する。
SELECT
  p.name AS project_name,
  p.budget,
  SUM(a.hours) AS total_hours,
  p.budget / SUM(a.hours) AS cost_per_hour
FROM assignments a
JOIN projects p ON a.project_id = p.id
GROUP BY p.id, p.name, p.budget;
---

**確認方法**

作成したデータベース構造やデータは、以下の手順で確認してください。

1. **DBeaverでの確認**
    - DBeaverを使用してテーブル構造やデータをGUIで確認してください。
    - `DESCRIBE`や`SELECT`文を使用してテーブル構造やデータをSQLクエリで確認してください。
2. **SQL文のエクスポートと管理**
    - DBeaverのエクスポート機能を使用して、作成したテーブルのデータをGitリポジトリで管理し、バージョン管理を行ってください。
    - エクスポートしたSQLファイルはGitリポジトリで管理し、バージョン管理を行ってください。
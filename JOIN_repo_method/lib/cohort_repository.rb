require "./lib/cohort"
require "./lib/student"

class CohortRepository
  def find_with_students(id)
    # Executes the SQL query:
    query = "SELECT students.id AS student_id, students.name AS student_name, cohorts.id AS cohort_id, cohorts.name, cohorts.starting_date 
    FROM cohorts
     JOIN students ON students.cohort_id = cohorts.id
     WHERE cohorts.id = $1;"

    params = [id]

    result = DatabaseConnection.exec_params(query, params)

    cohort = Cohort.new
    result.each do |x|
    end

    cohort.id = result.first["cohort_id"]
    cohort.name = result.first["name"]
    cohort.starting_date = result.first["starting_date"]

    result.each do |record|
      student = Student.new
      student.id = record["student_id"]
      student.name = record["student_name"]
      student.cohort_id = record["cohort_id"]

      # p student

      cohort.students << student
    end

    cohort

    #return a cohort object with array of student objects
  end
end

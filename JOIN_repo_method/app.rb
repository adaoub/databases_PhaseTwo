require_relative "./lib/cohort_repository"
require_relative "./lib/database_connection"

DatabaseConnection.connect("student_directory_2")

cohort = CohortRepository.new

result = cohort.find_with_students(1)
result.students.each do |student|
  p student.id
  p student.name
  p result.id
  p result.name
  p result.starting_date
end
# p result.student_name
# p result.cohort_id
# p result.name

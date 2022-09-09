require "cohort_repository"

def reset_cohorts_table
  seed_sql = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "student_directory_2" })
  connection.exec(seed_sql)
end

describe CohortRepository do
  before(:each) do
    reset_cohorts_table
  end

  it "finds a cohort and all its students" do
    repo = CohortRepository.new

    cohort = repo.find_with_students(1)

    expect(cohort.id).to eq "1"
    expect(cohort.name).to eq "September 2022"
    expect(cohort.starting_date).to eq "2022-09-15"
    expect(cohort.students.length).to eq 2
    expect(cohort.students.first.name).to eq "Bob"
  end
end

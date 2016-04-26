require_relative "../lib/api/back_log/back_log"

RSpec.describe BackLog do
  describe "Project" do
    all_projects = BackLog::Project.all
    any_project = BackLog::Project.all.first
    it "self.all" do
      expect( all_projects ).to be_is_a(Array)
      expect( all_projects.first ).to be_is_a(BackLog::Project)
    end

    it "self.find" do
      exsist_project = all_projects.first
      finding_project = BackLog::Project.find(exsist_project.id)
      expect(  finding_project.id ).to eq(exsist_project.id)
    end

    it "#mile_stones" do
      expect( any_project.mile_stones ).to be_is_a(Array)
      expect( any_project.mile_stones.first ).to be_is_a(BackLog::MileStone)
    end

    it "#types" do
      expect( any_project.types ).to be_is_a(Array)
      expect( any_project.types.first ).to be_is_a(BackLog::Type)
    end
  end
end

require 'xcodeproj'

project_path = '../MintynAssessment.xcodeproj'
project = Xcodeproj::Project.open(project_path)
target = project.targets.first

# Remove Main.storyboard and ViewController.swift
project.main_group.recursive_children.each do |file|
    if file.name == 'Main.storyboard' || file.name == 'ViewController.swift' || file.path == 'Base.lproj/Main.storyboard'
        file.remove_from_project
    end
end

target.build_phases.each do |phase|
    phase.files.each do |file|
        if file.file_ref.nil? || file.file_ref.name == 'Main.storyboard' || file.file_ref.name == 'ViewController.swift'
            file.remove_from_project
        end
    end
end

# Add new directories to the project
group_names = ['App', 'Core', 'Components', 'Modules']
main_group = project.main_group.children.find { |g| g.display_name == 'MintynAssessment' } || project.main_group
group_names.each do |group_name|
    group_path = "./#{group_name}"
    next unless Dir.exist?(group_path)

    # Check if group already exists
    group = main_group.children.find { |g| g.display_name == group_name }
    group ||= main_group.new_group(group_name, group_name)

    Dir.glob("#{group_path}/**/*.swift").each do |file_path|
        # Add file reference if not exists
        relative_path = file_path.sub("./#{group_name}/", "")
        file_ref = group.recursive_children.find { |g| g.path == relative_path }
        unless file_ref
            file_ref = group.new_file(relative_path)
            target.source_build_phase.add_file_reference(file_ref)
        end
    end
end

project.save
puts "Project updated successfully!"

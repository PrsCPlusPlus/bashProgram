student_file="students.txt"


add_student() {
    echo "Enter Student Name: "
    read name
    echo "Enter Student ID: "
    read id
    echo "Enter Student GPA: "
    read gpa

   
    echo "$id,$name,$gpa" >> "$student_file"
    echo "Student added successfully!"
}

view_students() {
    if [ ! -f "$student_file" ] || [ ! -s "$student_file" ]; then
        echo "No students found."
    else
        echo "ID, Name, GPA"
        echo "----------------------"
        cat "$student_file"
    fi
}

# Function to search for a student by ID
search_student() {
    echo "Enter Student ID to search: "
    read search_id

    result=$(grep "^$search_id," "$student_file")

    if [ -z "$result" ]; then
        echo "No student found with ID $search_id."
    else
        echo "Student found: $result"
    fi
}

# Function to delete a student by ID
delete_student() {
    echo "Enter Student ID to delete: "
    read delete_id

    # Check if student exists
    result=$(grep "^$delete_id," "$student_file")
    if [ -z "$result" ]; then
        echo "No student found with ID $delete_id."
    else
        # Remove the student from the file
        sed -i "/^$delete_id,/d" "$student_file"
        echo "Student with ID $delete_id deleted."
    fi
}

# Function to update a student's details
update_student() {
    echo "Enter Student ID to update: "
    read update_id

    # Check if student exists
    result=$(grep "^$update_id," "$student_file")
    if [ -z "$result" ]; then
        echo "No student found with ID $update_id."
    else
        # Prompt for new details
        echo "Enter new name: "
        read new_name
        echo "Enter new GPA: "
        read new_gpa

        # Update student information in file
        sed -i "/^$update_id,/c\\$update_id,$new_name,$new_gpa" "$student_file"
        echo "Student with ID $update_id updated."
    fi
}

# Function to load student data from a file (if the file exists)
load_students() {
    if [ -f "$student_file" ]; then
        echo "Student data loaded from file."
    else
        echo "No student data file found. Starting with an empty database."
    fi
}

# Main menu function
main_menu() {
    echo "==========================="
    echo " Student Management System"
    echo "==========================="
    echo "1. Add Student"
    echo "2. View All Students"
    echo "3. Search Student by ID"
    echo "4. Update Student"
    echo "5. Delete Student"
    echo "6. Exit"
    echo "==========================="
    echo "Enter your choice: "
    read choice
    case $choice in
        1) add_student ;;
        2) view_students ;;
        3) search_student ;;
        4) update_student ;;
        5) delete_student ;;
        6) exit ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
}

# Load student data on start
load_students

# Main loop to keep showing the menu
while true; do
    main_menu
done

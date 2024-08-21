// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentMarksRecord {
    address public owner;
    mapping(address => Student) public students;

    struct Student {
        string name;
        uint marks;
    }

    event StudentAdded(address indexed studentAddress, string name);
    event MarksUpdated(address indexed studentAddress, uint newMarks);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    // Add a new student record
    function addStudent(address studentAddress, string memory name) public onlyOwner {
        require(bytes(students[studentAddress].name).length == 0, "Student already exists");
        students[studentAddress] = Student(name, 0);
        emit StudentAdded(studentAddress, name);
    }

    // Update the marks for a student
    function updateMarks(address studentAddress, uint newMarks) public onlyOwner {
        require(bytes(students[studentAddress].name).length != 0, "Student does not exist");
        students[studentAddress].marks = newMarks;
        emit MarksUpdated(studentAddress, newMarks);
    }

    // Retrieve the marks of a student
    function getMarks(address studentAddress) public view returns (string memory name, uint marks) {
        require(bytes(students[studentAddress].name).length != 0, "Student does not exist");
        Student memory student = students[studentAddress];
        return (student.name, student.marks);
    }
}

CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'


rm -rf student-submission
rm -rf grading-area


mkdir grading-area


git clone $1 student-submission
if [ $? -ne 0 ]; then
echo "Failed to clone repository"
echo "Grade: 0"
exit 1
fi
echo 'Finished cloning'
if [[ -f student-submission/ListExamples.java ]]; then
echo "ListExamples.java found"
else
echo "ListExamples.java does not exist"
echo "Grade: 0"
exit 1
fi


cp student-submission/ListExamples.java grading-area/
cp TestListExamples.java grading-area/
cp -r lib grading-area/


cd grading-area
javac -cp $CPATH ListExamples.java TestListExamples.java
if [ $? -ne 0 ]; then
echo "Compilation failed"
echo "Grade: 0"
exit 1
fi


java -cp $CPATH org.junit.runner.JUnitCore TestListExamples
TEST_RESULT=$?


if [ $TEST_RESULT -eq 0 ]; then
echo "All tests passed"
echo "Grade: 100"
else
echo "Some tests failed"
echo "Grade: 50"
fi

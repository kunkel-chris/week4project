# Getting ang Cleaning Data - Week 4 Peer Reviewed Project Codebook

## Basic information
Sourced from the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Smartphone-Based+Recognition+of+Human+Activities+and+Postural+Transitions)

The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. They performed a protocol of activities composed of six basic activities: three static postures (standing, sitting, lying) and three dynamic activities (walking, walking downstairs and walking upstairs). The experiment also included postural transitions that occurred between the static postures. These are: stand-to-sit, sit-to-stand, sit-to-lie, lie-to-sit, stand-to-lie, and lie-to-stand. All the participants were wearing a smartphone (Samsung Galaxy S II) on the waist during the experiment execution. We captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz using the embedded accelerometer and gyroscope of the device. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of 561 features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

## Project Specific Updates
The code run_analysis.R creates the output dataset called "FinalTidyWeek4.txt" which contains the following fields:

1. Subject - Numeric identifier between 1 and 180, showing which subject's measurements are recorded.
2. Activity - Character string idenfitying the activity recorded for the given row. Values are:
  * LAYING
  * SITTING
  * STANDING
  * WALKING
  * WALKING_DOWNSTAIRS
  * WALKING_UPSTAIRS
3. Numeric variables representing the mean and standard deviation of various measurements for the given subject and acytivity. They use the following naming conventions:
  * Start with character "t" representing time domain or "f" representing frequency domain
  * Measurements include:
    * BodyAcc - Body component of accelerometer result in units of g (Earth gravity)
    * GravityAcc - Gravity component of accelerometer result in units of g
    * BodyAccJerk - Body component of accelerometer jerk
    * BodyGyro - Body component of gyroscope result in units of radians/second
    * BodyGyroJerk - Body component of gyroscope result in units of radians/second
    * BodyAccMag
    * GravityAccMag
    * BodyAccJerkMag
    * BodyGryoMag
  * Mean or StandardDeviation - indicates whether the value shows the mean or standard deviation of the given measurement for the given subject and activity
  * X, Y, or Z - indicates which axis the measurement corresponds to

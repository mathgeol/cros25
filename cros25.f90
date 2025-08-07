    MODULE CROSS_VARS
    IMPLICIT NONE
    REAL, DIMENSION(1500) :: A
    REAL, DIMENSION(250) :: B
    REAL, DIMENSION(1750) :: C
    REAL, DIMENSION(1750) :: CL
    REAL :: AMEAN, BMEAN
    END MODULE CROSS_VARS

    PROGRAM CROSS25
    USE CROSS_VARS
    IMPLICIT NONE
    CHARACTER(len=100) :: dated_file, undated_file, site_name
    CHARACTER(len=100) :: output_file          
    REAL, DIMENSION(:), ALLOCATABLE :: file_data
    REAL :: data
    REAL :: dated_name
    INTEGER :: K, MDATE, IDATE, I, J, L, KD, K10, IEND, L9, L11, L1, KL, NF, NG, NH, LAP, NV
    INTEGER :: UNITNR, num_files
    INTEGER :: count, status, unit_num, ios
    LOGICAL :: QUIT
    PARAMETER (UNITNR = 8)
      output_file = "./combined_output.out"              
      PRINT *, 'Input and Standardization'
    ! Open the undated tree file
    ! Single-column TRiCYCLE *.rw format
    ! Tree ring width integer = fourth to second-last record 
      print *, 'Please enter file name of the undated tree'
      read(*, '(A)') undated_file
      site_name = undated_file
801   open(unit=20, file=trim(undated_file), status='old', iostat=ios)
      if (ios /= 0) then
      print *, 'Error opening file!'
      stop
      end if
      print *, 'Site Name:', trim(site_name)
      close(20)
      OPEN (UNIT=unit_num, FILE=undated_file, STATUS='OLD', IOSTAT=status)
      IF (status /= 0) THEN
      PRINT *, "Error opening file"
      STOP
      END IF
      READ(unit_num, *)  
      READ(unit_num, *) 
      READ(unit_num, *) 
      count = 0
      DO
      READ(unit_num, *, IOSTAT=status) data
      IF (status /= 0) EXIT
      count = count + 1
      END DO
      REWIND(unit_num)
      ALLOCATE(file_data(count))
      L = 0  
      DO i = 1, count
      READ(unit_num, *, IOSTAT=status) file_data(i)
      IF (status == 0) THEN
      L = L + 1  
      END IF
      END DO
      PRINT *, "Total number of records read (L): ", L     
      CLOSE(unit_num)
      DEALLOCATE(file_data)
      REWIND(unit_num)
      GO to 101     
101   OPEN (UNIT=unit_num, FILE=undated_file, STATUS='OLD', IOSTAT=status)
      IF (status /= 0) THEN
      PRINT *, "Error opening file"
      STOP
      END IF
      READ(unit_num, *)  
      READ(unit_num, *) 
      READ(unit_num, *)        
      READ(unit_num, FMT='(F6.0)', END=102) (B(I), I=1,L) 
      PRINT *, 'Finished reading the file.'
      CLOSE(unit_num)
102   CONTINUE
    ! Standardization of the undated tree
      L = L - 4
      BMEAN = 0.0
      DO I = 1, L
      B(I) = ALOG(5*B(I+2)/(B(I)+B(I+1)+B(I+2)+B(I+3)+B(I+4)))
      BMEAN = BMEAN + B(I)
      END DO
      BMEAN = BMEAN / L
    ! Open the dated tree file
    ! Single-column TRiCYCLE *.rw format
    ! Third record = Inner year
    ! Tree width width integer = fourth to second-last record 
      PRINT *, 'Enter name of the dated tree, or STOP to end:'
      READ(*, '(A)') dated_file
      IF (TRIM(ADJUSTL(dated_file)) == 'STOP') QUIT = .TRUE.
      IF (QUIT) STOP
      OPEN(UNIT=10, FILE=TRIM(dated_file), STATUS='OLD', IOSTAT=ios)
      IF (ios /= 0) THEN
      PRINT *, 'Error opening dated tree file!'
      STOP
      END IF
      OPEN(UNIT=10, FILE=dated_file, STATUS='OLD', IOSTAT=ios)
      IF (ios /= 0) THEN
      PRINT *, 'Error opening file!'
      STOP
      END IF
      PRINT *, 'Dated Name:', dated_name
       READ(10, *)  
      READ(10, *) 
      READ(10, *) MDATE
      PRINT *, "Third record value (MDATE): ", MDATE
     ! Read and count records in the dated tree file
      count = 0
      DO
      READ(10, *, IOSTAT=status) data
      IF (status /= 0) EXIT
      count = count + 1
      END DO
      REWIND(10)
    ! Allocate memory and read the file data
      ALLOCATE(file_data(count))
      K = 0
      DO I = 1, count
      READ(10, *, IOSTAT=status) file_data(I)
      IF (status == 0) THEN
      K = K + 1
      END IF
      END DO
      DEALLOCATE(file_data)
      PRINT *, "Total number of records read (K): ", K     
      REWIND(10)
      READ(10, *)  
      READ(10, *) 
      READ(10, *)        
      READ(10, FMT='(F6.0)', END=301) (A(I), I=1,K) 
      PRINT *, 'Finished reading the file.'
      CLOSE(10)
301   CONTINUE
      IF (MDATE == 0) THEN
      IDATE = 15
      ELSE
      IDATE = MDATE + 14
      END IF
      PRINT *, 'MDATE =', MDATE 
      PRINT *, 'IDATE =', IDATE
      K = K - 4
      AMEAN = 0.0
      DO  I = 4, K
      A(I) = ALOG(5*A(I+2)/(A(I)+A(I+1)+A(I+2)+ A(I+3)+A(I+4)))
      AMEAN = AMEAN + A(I)
      END DO
      AMEAN = AMEAN / K
    ! Perform cross-dating
      L9 = L - 9
      L11 = L - 11
      DO NF = 1, L11
      CALL CALR(NF, 1, NF + 10, L9 - NF, NF + 10, NF)
      END DO
      L1 = L - 1
      KL = K - L + 1
      DO NG = 1, KL
      CALL CALR(NG, NG, NG + L1, 1, L, L11 + NG)
      END DO
      K10 = K - 10
    ! OUTPUT SECTION
      OPEN(UNIT=2, FILE=output_file, STATUS='UNKNOWN', ACTION='WRITE')
      IEND = ((K + L - 22) / 10) * 10
      DO KD = 1, IEND, 10
      K10 = KD + 9
      END DO      
      IDATE = IDATE + 10
      PRINT *, "Writing comparison for dated file:", TRIM(dated_file)
      WRITE(2,30) site_name, dated_file  
      DO L = 1, IEND
    ! Adjust the minimum t-value according to your requirements  
      IF (C(L) >= 3.5) THEN
      LAP = L + 13 + MDATE
      IF (LAP - MDATE > 80) THEN  ! overlapping interval
      IF (LAP < 2030) THEN  ! maximum IEND
      WRITE(2, 28) C(L), LAP
      END IF
      END IF
      END IF
      END DO
30    FORMAT("COMPARISON", 2X, A20, 5X,          " AND ",         15X, A20)
28    FORMAT(30x,"T =", F10.2, " DATE OF OUTER YEAR =", I4)
      CALL SLEEP(1)  ! Pause for 1 second between processing files
      GO TO 801
      CLOSE(UNIT=2)  
      END PROGRAM CROSS25
          
      SUBROUTINE CALR(N, NQ, NS, NT, NV, NW)
      USE CROSS_VARS
      IMPLICIT NONE
      REAL :: S1, S2, S3, XX, YY, SIGX, SIGY, CAL1, CAL2, CAL3
      INTEGER :: N, NQ, NS, NT, NV, NW, JJ, II
      S1 = 0.0
      S2 = 0.0
      S3 = 0.0
      JJ = NT - 1
        DO II= NQ, NS
        XX = A(II) - AMEAN
        JJ = JJ + 1
        YY = B(JJ) - BMEAN
        S1 = S1 + XX * XX  
        S2 = S2 + YY * YY
        S3 = S3 + XX * YY   
        END DO
        IF (S3 <= 0.0) THEN
        C(NW) = 0.0
        ELSE
        SIGX = SQRT(S1 / NV)
        SIGY = SQRT(S2 / NV)
        CAL1 = S3 / (NV * SIGX * SIGY)
        CAL2 = SQRT(NV - 2.0)          
        CAL3 = SQRT(1.0 - CAL1 * CAL1) 
        C(NW) = CAL1 * CAL2 / CAL3      
        END IF
        RETURN
        END SUBROUTINE CALR

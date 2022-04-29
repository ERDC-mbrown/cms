!***********************************************************************************************************************    
    module tool_def
      implicit none
      
      interface vstrlz                        !Overload the function so that it works for both real(4) and real(8) variables  MEB  03/29/2022
        module procedure vstrlz4, vstrlz8
      end interface

      interface rround                        !Overload the function so that it works for both real(4) and real(8) variables  MEB  04/05/2022
        module procedure rround4, rround8
      end interface
  
      contains
!************************************************************
      function vstrlz4(flt,gfmt) result(gbuf)
! This function will take a single precision float (4-bit) variable and a format declaration, then convert it to a string. 
! The string will add a leading 0, +0, or -0 if necessary.  Also, it will remove a leading space from the PE format
      character(len=20)                      :: gbuf
      real, intent(in)                       :: flt
      character(len=*), optional, intent(in) :: gfmt
      character(len=40)                      :: gtmp
      integer                                :: istat

      gtmp = ''
      if(present(gfmt) ) then   ! specified format
        write(gtmp, gfmt, iostat=istat ) flt  
      else                      ! generic format
        write(gtmp, '(g0)', iostat=istat) flt  
      endif
      
      if( istat /= 0 ) then
        gbuf='****'
        return
      endif
      
      if    (gtmp(1:1) == '.' ) then
        gbuf = '0'//trim(gtmp)
      elseif(gtmp(1:2) == '-.' ) then
        gbuf = '-0.'//trim(gtmp(3:))
      elseif(gtmp(1:2) == '+.' ) then ! S format adds a +
        gbuf = '+0.'//trim(gtmp(3:))
      else
        gbuf = trim(adjustl(gtmp))
      endif
      
      return
      end function vstrlz4

!************************************************************
      function vstrlz8(flt,gfmt) result(gbuf)
! This function will take a double precision float (8-bit) variable and a format declaration, then convert it to a string. 
! The string will add a leading 0, +0, or -0 if necessary.  Also, it will remove a leading space from the PE format
      character(len=20)                      :: gbuf
      real(8), intent(in)                    :: flt
      character(len=*), optional, intent(in) :: gfmt
      character(len=40)                      :: gtmp
      integer                                :: istat

      gtmp = ''
      if(present(gfmt) ) then   ! specified format
        write(gtmp, gfmt, iostat=istat ) flt  
      else                      ! generic format
        write(gtmp, '(g0)', iostat=istat) flt  
      endif
      
      if( istat /= 0 ) then
        gbuf='****'
        return
      endif
      
      if    (gtmp(1:1) == '.' ) then
        gbuf = '0'//trim(gtmp)
      elseif(gtmp(1:2) == '-.' ) then
        gbuf = '-0.'//trim(gtmp(3:))
      elseif(gtmp(1:2) == '+.' ) then ! S format adds a +
        gbuf = '+0.'//trim(gtmp(3:))
      else
        gbuf = trim(adjustl(gtmp))
      endif
      
      return
      end function vstrlz8
      
!****************************************************
! double precision rounding function - 12/06/07 meb
!   two inputs - value, and #digits to round off to
!   returns - rounded value to specified precision
!
!   This and single precision version - combined into 
!   overloaded function 'rround' - MEB  04/05/22
!****************************************************
    double precision function rround8 (X,P)    
    use prec_def
    implicit none
    real(8) X    !double precision value passed in
    integer K,P  !digits of precision
    real(8) PR,R
    
    PR=10.d0**P      
    K = NINT(PR*(X-AINT(X))) 
    R = AINT(X) + K/PR
    RROUND8 = R
    
    end function rround8
  
!****************************************************
! single precision rounding function - 12/06/07 meb
!   two inputs - value, and #digits to round off to
!   returns - rounded value to specified precision
!
!   This and double precision version - combined into 
!   overloaded function 'rround' - MEB  04/05/22
!****************************************************
    real function rround4 (X,P)
    implicit none
    real(4) X    !real value passed in
    integer K,P  !digits of precision
    real(4) PR,R
    
    PR=10.0**P      
    K = NINT(PR*(X-AINT(X))) 
    R = AINT(X) + K/PR
    RROUND4 = R
    
    end function rround4
    
        
!************************************************************
  pure function addQuotes(str) result(delimited)
! "Returns the delivered string surrounded by single quotes."
! Added by Mitchell Brown, 04/25/2022
!************************************************************
    character(*), intent(in) :: str
    character(len(str)+2) delimited

    delimited = "'"//str//"'"
  end function addQuotes


!************************************************************
    end module tool_def      
public class PatternMatcher {
    
    static final String REGEX_EMAIL     =   '([a-zA-Z0-9_\\-\\.\\+]+)@((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})';
    static final String REGEX_DATE  =   '(0?[1-9]|[12][0-9]|3[01])/(0?[1-9]|1[012])/((19|20)\\d\\d)';
    
    public PatternMatcher() {}
    
    public static boolean validate_Email(String email) {
        Pattern p = Pattern.compile(REGEX_EMAIL);
        Matcher m = p.Matcher(email);
        if(!m.matches()) {
            return false;
        } else {
            return true;
        }
    }
}
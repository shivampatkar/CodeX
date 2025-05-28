package utils;

import java.util.Random;
import java.util.Date;

public class GenerateCode {
     public static String getVerificationCode() {
        return Math.abs(new Random().nextLong()) + "_" + new Date().getTime();
    }
}

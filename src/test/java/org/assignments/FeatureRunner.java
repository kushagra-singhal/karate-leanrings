package org.assignments;

import com.intuit.karate.junit5.Karate;

class FeatureRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("assignment").relativeTo(getClass());
    }

}



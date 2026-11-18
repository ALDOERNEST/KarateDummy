package ecommerce;

import com.intuit.karate.junit5.Karate;

class EcommerceRunner {

    @Karate.Test
    Karate testEcommerce() {
        return Karate.run().relativeTo(getClass());
    }
}
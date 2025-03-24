import FeaturedVendor from "@/components/FeaturedVendors";
import Hero from "@/components/hero/page";
import H3 from "@/components/H3";

import Image from "next/image";

export default function Home() {
    return (
        <>
            <section>
                <Hero />
            </section>

            <section className="max-w-7xl mx-auto px-4 py-12">
                <H3>FEATURED VENDORS</H3>
                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mt-8 gap-4">
                    <FeaturedVendor
                        aspect_ratio="3/4.5"
                        image_path="/images/food-1.jpg"
                        image_alt="Vendor 1"
                        vendor="Vendor 1 is not working out how things work"
                    />

                    <div className="grid grid-rows-2 gap-2">
                        <FeaturedVendor
                            aspect_ratio="3/2.2"
                            image_path="/images/food-4.jpg"
                            image_alt="Vendor 1"
                            vendor="Vendor 1"
                        />
                        <FeaturedVendor
                            aspect_ratio="3/2.2"
                            image_path="/images/food-3.jpg"
                            image_alt="Vendor 1"
                            vendor="Vendor 1"
                        />
                    </div>

                    <FeaturedVendor
                        aspect_ratio="3/4.5"
                        image_path="/images/food-1.jpg"
                        image_alt="Vendor 1"
                        vendor="Vendor 1"
                    />

                    <div className="grid grid-rows-2 gap-2">
                        <FeaturedVendor
                            aspect_ratio="3/2.2"
                            image_path="/images/food-4.jpg"
                            image_alt="Vendor 1"
                            vendor="Vendor 1"
                        />
                        <FeaturedVendor
                            aspect_ratio="3/2.2"
                            image_path="/images/food-3.jpg"
                            image_alt="Vendor 1"
                            vendor="Vendor 1"
                        />
                    </div>
                </div>
            </section>
        </>
    );
}

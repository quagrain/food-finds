import FeaturedVendor from "@/components/FeaturedVendors";
import TopPick from "@/components/TopPick";
import Hero from "@/components/hero/page";
import H3 from "@/components/H3";
import path from "path/win32";

export default function Home() {
  return (
    <>
      <section>
        <Hero />
      </section>

      <section className="mx-auto pt-12 pb-6">
        <H3>FEATURED VENDORS</H3>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 mt-8 gap-4">
          <FeaturedVendor
            aspect_ratio="full"
            image_path="/images/food-1.jpg"
            image_alt="Vendor 1"
            vendor="Vendor 1"
          />

          <div className="grid grid-rows-2 gap-2">
            <FeaturedVendor
              aspect_ratio="stack"
              image_path="/images/food-4.jpg"
              image_alt="Vendor 1"
              vendor="Vendor 1"
            />
            <FeaturedVendor
              aspect_ratio="stack"
              image_path="/images/food-3.jpg"
              image_alt="Vendor 1"
              vendor="Vendor 1"
            />
          </div>

          <FeaturedVendor
            aspect_ratio="full"
            image_path="/images/food-1.jpg"
            image_alt="Vendor 1"
            vendor="Vendor 1"
          />

          <div className="grid grid-rows-2 gap-2">
            <FeaturedVendor
              aspect_ratio="stack"
              image_path="/images/food-4.jpg"
              image_alt="Vendor 1"
              vendor="Vendor 1"
            />
            <FeaturedVendor
              aspect_ratio="stack"
              image_path="/images/food-3.jpg"
              image_alt="Vendor 1"
              vendor="Vendor 1"
            />
          </div>
        </div>
      </section>

      <section className="mx-auto pt-6 pb-6">
        <H3>TOP PICKS</H3>
        <div className="grid grid-cols-5 mt-6 gap-4">
          <TopPick
            imageData={{ path: "/images/food-2.jpg", alt: "Vendor Image" }}
            vendorName="Canon "
            foodName="Tea"
            foodPrice="$100.00"
            rating="10.00"
          />
        </div>
      </section>
    </>
  );
}

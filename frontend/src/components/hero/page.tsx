"use client";

import Image from "next/image";
import { useState } from "react";

import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuRadioGroup,
  DropdownMenuRadioItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import H2 from "@/components/H2";
import H3 from "@/components/H3";

export default function Hero() {
  const [position, setPosition] = useState<string>("ashesi");

  return (
    <>
      <div className="relative h-[300px] overflow-hidden rounded-xl">
        <Image
          src="/images/hero.png"
          alt="Hero section with an image of different food"
          fill
          priority
        />
        <div className="absolute inset-0 bg-black/40 flex flex-col justify-center items-center text-white text-center">
          <H2 className="text-3xl md:text-4xl font-bold mb-2">
            Find vendors in your campus!
          </H2>
          <p className="text-lg">
            Discover a variety of options at your fingertips!
          </p>
        </div>
      </div>

      <div className="max-w-4xl mx-auto px-4 -mt-8 relative">
        <div className="grid grid-cols-4 bg-white rounded-full border overflow-hidden">
          <DropdownMenu>
            <DropdownMenuTrigger className="p-4 border-r text-center hover:cursor-pointer hover:bg-gray-100 decoration-0">
              <H3 className="font-normal text-xl">Campus</H3>
              <p className="text-sm text-black/60">Select campus</p>
            </DropdownMenuTrigger>
            <DropdownMenuContent>
              <DropdownMenuRadioGroup
                value={position}
                onValueChange={setPosition}
                className="max-w-60"
              >
                <DropdownMenuRadioItem value="acity">
                  Academic City
                </DropdownMenuRadioItem>
                <DropdownMenuRadioItem value="ashesi">
                  Ashesi University
                </DropdownMenuRadioItem>
                <DropdownMenuRadioItem value="ug">
                  University of Ghana, Legon
                </DropdownMenuRadioItem>
              </DropdownMenuRadioGroup>
            </DropdownMenuContent>
          </DropdownMenu>
          <div className="p-4 border-r text-center">
            <H3 className="font-normal text-xl">Menu</H3>
            <p className="text-sm text-black/60">View items</p>
          </div>
          <div className="p-4 border-r text-center">
            <H3 className="font-normal text-xl">Cart</H3>
            <p className="text-sm text-black/60">Review order</p>
          </div>
          <div className="flex items-center justify-between p-4">
            <div className="text-center flex-1">
              <H3 className="font-normal text-xl">Discounts</H3>
              <p className="text-sm text-black/60">Special offers</p>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}

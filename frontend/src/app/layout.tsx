import {ThemeProvider} from "next-themes";
import type {Metadata} from "next";

import "./globals.css";
import Home from "@/app/home/page";
import NavBar from "@/app/navbar/page";

export const metadata: Metadata = {
  title: "Food Finds",
  description: "A food ordering app for university students.",
};

export default function RootLayout({children}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body className="bg-background">
        <NavBar />
        <Home />
        <ThemeProvider>{children}</ThemeProvider>
      </body>
    </html>
  );
}

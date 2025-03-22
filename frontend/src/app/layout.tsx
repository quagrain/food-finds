import {ThemeProvider} from "next-themes";
import type {Metadata} from "next";

import "./globals.css";
import NavBar from "@/components/navbar/page";

export const metadata: Metadata = {
  title: "Food Finds",
  description: "A food ordering app for university students.",
};

export default function RootLayout({children}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en" suppressHydrationWarning>
      <body>
        <NavBar />
        <ThemeProvider>
          <main className="mx-auto max-w-6xl px-3 py-10">
            {children}
          </main>
        </ThemeProvider>
      </body>
    </html>
  );
}

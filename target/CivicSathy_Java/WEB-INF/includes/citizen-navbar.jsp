<%-- 
    Citizen Bottom Navigation Component
    Features: Fixed bottom layout, central Camera FAB, Icy Cyan tints.
--%>
<nav class="fixed bottom-0 w-full max-w-md bg-white/90 backdrop-blur-lg border-t border-brand-border py-2 px-6 shadow-nav z-40">
    <div class="flex items-center justify-between relative">
        
        <!-- this is feed link -->
        <a href="${pageContext.request.contextPath}/citizen/public-feed.jsp" class="flex flex-col items-center gap-1 group transition-all">
            <div class="p-1.5 rounded-md group-hover:bg-brand-cyan/40 transition-colors">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-brand-trust" viewBox="0 0 20 20" fill="currentColor">
                    <path d="M10.707 2.293a1 1 0 00-1.414 0l-7 7a1 1 0 001.414 1.414L4 10.414V17a1 1 0 001 1h2a1 1 0 001-1v-2a1 1 0 011-1h2a1 1 0 011 1v2a1 1 0 001 1h2a1 1 0 001-1v-6.586l.293.293a1 1 0 001.414-1.414l-7-7z" />
                </svg>
            </div>
            <span class="text-[9px] font-bold text-brand-trust uppercase tracking-tighter">Feed</span>
        </a>

        <!-- this is emergency link -->
        <a href="${pageContext.request.contextPath}/citizen/emergency.jsp" class="flex flex-col items-center gap-1 group transition-all">
            <div class="p-1.5 rounded-md group-hover:bg-brand-cyan/40 transition-colors">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-brand-muted group-hover:text-brand-black transition-colors" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.268 17c-.77 1.333.192 3 1.732 3z" />
                </svg>
            </div>
            <span class="text-[9px] font-bold text-brand-muted group-hover:text-brand-black uppercase tracking-tighter transition-colors">SOS</span>
        </a>

        <!-- this is central camera fab (smart submit) -->
        <div class="absolute left-1/2 -translate-x-1/2 -top-10">
            <a href="${pageContext.request.contextPath}/citizen/submit-complaint.jsp" class="w-16 h-16 bg-brand-trust rounded-full flex items-center justify-center shadow-lg border-4 border-brand-bg hover:scale-105 transition-transform active:scale-95">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
            </a>
        </div>

        <!-- this is track link -->
        <a href="${pageContext.request.contextPath}/citizen/track.jsp" class="flex flex-col items-center gap-1 group transition-all ml-16">
            <div class="p-1.5 rounded-md group-hover:bg-brand-cyan/40 transition-colors">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-brand-muted group-hover:text-brand-black transition-colors" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01" />
                </svg>
            </div>
            <span class="text-[9px] font-bold text-brand-muted group-hover:text-brand-black uppercase tracking-tighter transition-colors">Track</span>
        </a>

        <!-- this is profile link -->
        <a href="${pageContext.request.contextPath}/citizen/profile.jsp" class="flex flex-col items-center gap-1 group transition-all">
            <div class="p-1.5 rounded-md group-hover:bg-brand-cyan/40 transition-colors">
                <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-brand-muted group-hover:text-brand-black transition-colors" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                </svg>
            </div>
            <span class="text-[9px] font-bold text-brand-muted group-hover:text-brand-black uppercase tracking-tighter transition-colors">Profile</span>
        </a>

    </div>
</nav>



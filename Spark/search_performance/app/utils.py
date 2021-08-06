class utils():
    def get_domain(st):
        try:
            start = st.find("://www.") + len("://www.")
            end = st.find(".com") + len(".com")
            return st[start:end]
        except ValueError:
            return ""
